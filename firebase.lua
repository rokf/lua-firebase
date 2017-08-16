
local cjson = require 'cjson'
local request = require 'http.request'
-- local headers = require 'http.headers'

local print_headers = function (h)
  for name, value, never_index in h:each() do
    print(name, value, never_index)
  end
end

local get = function (pid,path,dflag,auth)
  local authstring = ""
  if auth then authstring = "?access_token=" .. auth end
  local uri = string.format("https://%s.firebaseio.com/%s.json%s",pid,path,authstring)
  local h,s = request.new_from_uri(uri):go()
  if h:get(":status") ~= "200" then return nil, h:get(":status"), s:get_body_as_string() end
  if dflag then return cjson.decode(s:get_body_as_string()) end -- table
  return s:get_body_as_string() -- JSON string
end

local upload_backend = function (method,pid,path,data,eflag,auth)
  local authstring = ""
  if auth then authstring = "?access_token=" .. auth end
  local datastring = ""
  if eflag then datastring = cjson.encode(data) else datastring = data end
  local uri = string.format("https://%s.firebaseio.com/%s.json%s",pid,path,authstring)
  local r = request.new_from_uri(uri)
  r.headers:upsert(":method",method,false)
  r.headers:upsert("content-type","application/json",false)
  r.headers:upsert("content-length",tostring(#datastring),false)
  r:set_body(datastring)
  local h,s = r:go()
  if h:get(":status") ~= "200" then return nil, h:get(":status"), s:get_body_as_string() end
  return s:get_body_as_string()
end

local put = function (pid,path,data,eflag,auth)
  return upload_backend("PUT",pid,path,data,eflag,auth)
end

local post = function (pid,path,data,eflag,auth)
  return upload_backend("POST",pid,path,data,eflag,auth)
end

local patch = function (pid,path,data,eflag,auth)
  return upload_backend("PATCH",pid,path,data,eflag,auth)
end

local delete = function (pid,path,auth)
  local authstring = ""
  if auth then authstring = "?access_token=" .. auth end
  local uri = string.format("https://%s.firebaseio.com/%s.json%s",pid,path,authstring)
  local r = request.new_from_uri(uri)
  r.headers:upsert(":method","DELETE",false)
  local h,s = r:go()
  if h:get(":status") ~= "200" then return nil, h:get(":status"), s:get_body_as_string() end
  return s:get_body_as_string()
end

-- auth REST API --

local idtoolkit_reqcore = function (appstr,t,key)
  local uri = string.format("https://www.googleapis.com/identitytoolkit/v3/relyingparty/%s?key=%s",appstr,key)
  local r = request.new_from_uri(uri)
  r.headers:upsert(":method","POST",false)
  r.headers:upsert("content-type","application/json",false)
  local datastring = cjson.encode(t)
  r.headers:upsert("content-length",tostring(#datastring),false)
  r:set_body(datastring)
  local h,s = r:go()
  if h:get(":status") ~= "200" then return nil, h:get(":status"), s:get_body_as_string() end
  return cjson.decode(s:get_body_as_string())
end

local signin_email = function (email,password,key)
  return idtoolkit_reqcore("verifyPassword",{email=email,password=password,returnSecureToken=true},key)
end

local signup_email = function (email,password,key)
  return idtoolkit_reqcore("signupNewUser",{email=email,password=password,returnSecureToken=true},key)
end

local delete_account = function (idtoken,key)
  return idtoolkit_reqcore("deleteAccount",{idToken=idtoken},key)
end

local change_password = function (idtoken,password,key)
  return idtoolkit_reqcore("setAccountInfo",{idToken=idtoken,password=password,returnSecureToken=true},key)
end

local change_email = function (idtoken,email,key)
  return idtoolkit_reqcore("setAccountInfo",{idToken=idtoken,email=email,returnSecureToken=true},key)
end

local get_new_idtoken = function (rtoken,key)
  local uri = string.format("https://securetoken.googleapis.com/v1/token?key=%s",key)
  local r = request.new_from_uri(uri)
  r.headers:upsert(":method","POST",false)
  r.headers:upsert("content-type","application/x-www-form-urlencoded",false)
  local datastring = cjson.encode({
    grant_type = "refresh_token",
    refresh_token = rtoken
  })
  -- r.headers:upsert("content-length",tostring(#datastring),false)
  r:set_body(datastring)
  local h,s = r:go()
  if h:get(":status") ~= "200" then return nil, h:get(":status"), s:get_body_as_string() end
  return cjson.decode(s:get_body_as_string())
end

return {
  get = get,
  put = put,
  post = post,
  patch = patch,
  delete = delete,
  -- auth related
  signin_email = signin_email,
  signup_email = signup_email,
  get_new_idtoken = get_new_idtoken,
  delete_account = delete_account,
  change_password = change_password,
  change_email = change_email
}
