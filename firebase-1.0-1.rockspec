package = "firebase"
version = "1.0-1"
source = {
  url = "https://github.com/rokf/lua-firebase"
}

description = {
  summary = "A Firebase database REST module in Lua",
  detailed = [[
    This is a Lua module for the Firebase database service.
  ]],
  homepage = "https://github.com/rokf/lua-firebase",
  license = "MIT",
}

dependencies = {
  "lua >= 5.1",
  "lua-cjson >= 2.1.0-1",
  "luasec >= 0.6-1"
}

build = {
  type = "builtin",
  modules = {
    firebase = "firebase.lua"
  }
}