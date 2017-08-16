
local signin_email = function (email,password,key)
  local uri = string.format("https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=%s",key)
  local r = request.new_from_uri(uri)
  r.headers:upsert(":method","POST",false)
  r.headers:upsert("content-type","application/json",false)
  local datastring = cjson.encode({
    email = email,
    password = password,
    returnSecureToken = true
  })
  r.headers:upsert("content-length",tostring(#datastring),false)
  r:set_body(datastring)
  local h,s = r:go()
  if h:get(":status") ~= "200" then return nil, h:get(":status"), s:get_body_as_string() end
  return cjson.decode(s:get_body_as_string())
end

local signup_email = function (email,password,key)
  local uri = string.format("https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=%s",key)
  local r = request.new_from_uri(uri)
  r.headers:upsert(":method","POST",false)
  r.headers:upsert("content-type","application/json",false)
  local datastring = cjson.encode({
    email = email,
    password = password,
    returnSecureToken = true
  })
  r.headers:upsert("content-length",tostring(#datastring),false)
  r:set_body(datastring)
  local h,s = r:go()
  if h:get(":status") ~= "200" then return nil, h:get(":status"), s:get_body_as_string() end
  return cjson.decode(s:get_body_as_string())
end

local delete_account = function (idtoken,key)
  local uri = string.format("https://www.googleapis.com/identitytoolkit/v3/relyingparty/deleteAccount?key=%s",key)
  local r = request.new_from_uri(uri)
  r.headers:upsert(":method","POST",false)
  r.headers:upsert("content-type","application/json",false)
  local datastring = cjson.encode({
    idToken = idtoken
  })
  r.headers:upsert("content-length",tostring(#datastring),false)
  r:set_body(datastring)
  local h,s = r:go()
  if h:get(":status") ~= "200" then return nil, h:get(":status"), s:get_body_as_string() end
  return cjson.decode(s:get_body_as_string())
end

local change_password = function (idtoken,password,key)
  local uri = string.format("https://www.googleapis.com/identitytoolkit/v3/relyingparty/setAccountInfo?key=%s",key)
  local r = request.new_from_uri(uri)
  r.headers:upsert(":method","POST",false)
  r.headers:upsert("content-type","application/json",false)
  local datastring = cjson.encode({
    idToken = idtoken,
    password = password,
    returnSecureToken = true
  })
  r.headers:upsert("content-length",tostring(#datastring),false)
  r:set_body(datastring)
  local h,s = r:go()
  if h:get(":status") ~= "200" then return nil, h:get(":status"), s:get_body_as_string() end
  return cjson.decode(s:get_body_as_string())
end

local change_email = function (idtoken,email,key)
  local uri = string.format("https://www.googleapis.com/identitytoolkit/v3/relyingparty/setAccountInfo?key=%s",key)
  local r = request.new_from_uri(uri)
  r.headers:upsert(":method","POST",false)
  r.headers:upsert("content-type","application/json",false)
  local datastring = cjson.encode({
    idToken = idtoken,
    email = email,
    returnSecureToken = true
  })
  r.headers:upsert("content-length",tostring(#datastring),false)
  r:set_body(datastring)
  local h,s = r:go()
  if h:get(":status") ~= "200" then return nil, h:get(":status"), s:get_body_as_string() end
  return cjson.decode(s:get_body_as_string())
end
