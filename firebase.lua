
-- https://github.com/mikexstudios/python-firebase/blob/master/firebase/__init__.py

local https = require("ssl.https")
local cjson = require("cjson")
local ltn12 = require("ltn12")

local Firebase = {}

Firebase.ROOT_URL = ''

-- Firebase API calls

function Firebase:init(root_url)
  --  self.ROOT_URL = string.sub(root_url, 1, -2)..'.json'
  if string.sub(root_url,-1) == '/' then
    self.ROOT_URL = string.sub(root_url, 1, -2)
  else
    self.ROOT_URL = root_url
  end
end

function Firebase:set(path, data)
  https.request({
      url = self.ROOT_URL..path..'.json',
      method = "PUT",
      sink = ltn12.sink.table({}),
      source = ltn12.source.string(cjson.encode(data)),
      headers = {
         ["content-length"] = #cjson.encode(data),
         ["content-type"] = "application/x-www-form-urlencoded",
      }
  })
end

function Firebase:push(path, data)
  https.request(self.ROOT_URL..path..'.json', cjson.encode(data))
end

function Firebase:remove(path)
  https.request({
      url = self.ROOT_URL..path..'.json',
      method = "DELETE"
  })
end

-- REST API functionality

function Firebase:put(path, data)
  https.request({
      url = self.ROOT_URL..path..'.json',
      method = "PUT",
      sink = ltn12.sink.table({}),
      source = ltn12.source.string(cjson.encode(data)),
      headers = {
         ["content-length"] = #cjson.encode(data),
         ["content-type"] = "application/x-www-form-urlencoded",
      }
  })
end

function Firebase:get(path, do_decoding)
  if path then
    local result = https.request(self.ROOT_URL..path..'.json')
    result = string.sub(result,1,string.find(result,"}[^}]*$"))
    if do_decoding == true then
      return cjson.decode(result) -- return as a table
    else
      return result -- return as json string
    end
  else
    local result = https.request(self.ROOT_URL..'.json')
    result = string.sub(result,1,string.find(result,"}[^}]*$"))
    if do_decoding == true then
      return cjson.decode(result) -- return as a table
    else
      return result -- return as json string
    end
  end
end

function Firebase:post(path, data)
  https.request(self.ROOT_URL..path..'.json', cjson.encode(data))
end

function Firebase:delete(path)
  https.request({
      url = self.ROOT_URL..path..'.json',
      method = "DELETE"
  })
end

return Firebase
