
-- Inspired by the Python binding

local https = require("ssl.https")
local cjson = require("cjson")
local ltn12 = require("ltn12")

local Firebase = {}

Firebase.ROOT_URL = ''

function Firebase:encode(data)  -- return data table in json string format
  return cjson.encode(data)
end

function Firebase:decode(json_string)  -- take json_string and return lua table
  return cjson.decode(json_string)
end

function Firebase:init(name)
  self.ROOT_URL = string.format("https://%s.firebaseio.com/", name)
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

function Firebase:download(path,filename)
  local file = io.open(filename, "w")
  file:write(self:get(path, false))
  file:close()
end

function Firebase:upload(path, filename)
  local file = io.open(filename, "r")
  local content_string = file:read("*all")
  file:close()
  https.request(self.ROOT_URL..path..'.json', content_string)
end

function Firebase:get(path, do_decoding)
  local URL = self.ROOT_URL .. path .. ".json"
  local result = https.request(URL)
  if do_decoding then
    return self:decode(result), "table"
  end
  return result, "string"
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
