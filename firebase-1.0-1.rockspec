package = "firebase"
version = "1.0-1"
source = {
  url = "git://github.com/rokf/lua-firebase",
  tag = "v1.0"
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
