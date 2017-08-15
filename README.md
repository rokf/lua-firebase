
![Firebase logo](https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png) ![Lua logo](http://www.rozek.mobi/Lua/Lua-Logo_64x64.png)

A Firebase REST database binding for Lua

#### Dependencies
```
sudo luarocks install http
sudo luarocks install lua-cjson
```

#### Functions
```
get = function (pid,path,dflag,auth)
put = function (pid,path,data,eflag,auth)
post = function (pid,path,data,eflag,auth)
patch = function (pid,path,data,eflag,auth)
delete = function (pid,path,auth)
```

#### Explanations
- `pid` - project ID (string)
- `path` - relative path without `.json` at the end (string)
- `data` - either a Lua table or valid JSON string (table / string)
- `eflag` - encode flag, if true then data is expected to be a Lua table (boolean)
- `auth` - token (string)
