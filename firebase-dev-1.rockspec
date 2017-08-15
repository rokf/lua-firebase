package = "firebase"
version = "dev-1"

source = {
  url = "git://github.com/rokf/lua-firebase",
}

description = {
  summary = "A Firebase RTDB REST module in Lua",
  homepage = "https://github.com/rokf/lua-firebase",
  maintainer = "Rok Fajfar <snewix7@gmail.com>",
  license = "MIT",
}

dependencies = {
  "lua >= 5.1",
  "lua-cjson",
  "http"
}

build = {
  type = "builtin",
  modules = {
    firebase = "firebase.lua"
  }
}
