
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
- `dflag` - decode flag, if true then data is decoded to Lua table, otherwise returned as JSON string (boolean)
- `eflag` - encode flag, if true then data is expected to be a Lua table (boolean)
- `auth` - token (string)

#### Auth-related functions
```
signin_email = function (email,password,key)
signup_email = function (email,password,key)
get_new_idtoken = function (rtoken,key)
```

#### Auth explanations
```
- `email` - user email (string)
- `password` - user password (string)
- `key` - Firebase project KEY (string)
- `rtoken` - `refresh_token`, used to gain a new ID token (string)
```
