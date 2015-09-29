A Firebase binding which uses **luasec** for **https**.

You will need this

```
sudo luarocks install LuaSec
sudo luarocks install lua-cjson
```

and the `firebase.lua` file which is **not yet** on LuaRocks. Just get it from the repository.

###How to use?

```lua
local firebase = require('firebase')

firebase:init('https://your-firebase-app-here.firebaseio.com/')

firebase:put("/example",{is_working = true})
firebase:set("/example/another_one",{really = "still true"})
firebase:delete("/example/another_one")

local normal = firebase:get("/example", false) -- if false then its returned as json string
local is_decoded = firebase:get("/example", true) -- if true it is decoded into a table
```

##AUTH not yet supported :snail: