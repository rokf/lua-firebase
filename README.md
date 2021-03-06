![Firebase logo](https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png)

A Firebase REST database binding for Lua

#### Dependencies
```
sudo luarocks install http
sudo luarocks install lua-cjson
```

**Note:** This module will not work on platforms where lua-http (`http`) can't be installed on.
It only works on unix-like operating systems (Linux, OSX, ...).

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
delete_account = function (idtoken,key)
change_password = function (idtoken,password,key)
change_email = function (idtoken,email,key)
```

#### Auth explanations
- `email` - users email (string)
- `password` - user password (string)
- `key` - Firebase project KEY (string)
- `rtoken` - `refresh_token`, used to gain a new ID token (string)
- `idtoken` - user ID token (string)
