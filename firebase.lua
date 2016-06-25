
local https = require("ssl.https")
local cjson = require("cjson")
local ltn12 = require("ltn12")

local Firebase = {}

Firebase.ROOT_URL = ''

function Firebase:encode(data) -- return data table in json string format
  return cjson.encode(data)
end

function Firebase:decode(json_string) -- take json_string and return lua table
  return cjson.decode(json_string)
end

function Firebase:init(name) -- INIT
  self.ROOT_URL = string.format("https://%s.firebaseio.com/", name)
end

function Firebase:init_manual(full_url)
  self.ROOT_URL = full_url
end

function Firebase:set(path, data) -- SET
  local encoded = cjson.encode(data)
  https.request({
    url = self.ROOT_URL..path..'.json',
    method = "PUT",
    sink = ltn12.sink.table({}),
    source = ltn12.source.string(encoded),
    headers = {
      ["content-length"] = #encoded,
      ["content-type"] = "application/x-www-form-urlencoded",
    }
  })
end

function Firebase:put(path, data) -- ALIAS
  self:set(path,data)
end

function Firebase:putraw(path, rawstring) -- PUT RAW JSON
  https.request({
    url = self.ROOT_URL..path..'.json',
    method = "PUT",
    sink = ltn12.sink.table({}),
    source = ltn12.source.string(rawstring),
    headers = {
      ["content-length"] = #rawstring,
      ["content-type"] = "application/x-www-form-urlencoded",
    }
  })
end

function Firebase:push(path, data) -- PUSH
  https.request(self.ROOT_URL..path..'.json', cjson.encode(data))
end

function Firebase:post(path, data) -- ALIAS
  self:push(path,data)
end

function Firebase:pushraw(path, rawstring) -- PUSH RAW JSON
  https.request(self.ROOT_URL..path..'.json', rawstring)
end

function Firebase:remove(path) -- REMOVE
  https.request({
    url = self.ROOT_URL..path..'.json',
    method = "DELETE"
  })
end

function Firebase:delete(path) -- ALIAS
  self:remove(path)
end

function Firebase:get(path, do_decoding) -- GET
  local URL = self.ROOT_URL .. path .. ".json"
  local result = https.request(URL)
  if do_decoding then
    return self:decode(result), "table"
  end
  return result, "string"
end

return Firebase
