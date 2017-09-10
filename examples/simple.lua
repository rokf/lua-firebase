
-- THIS CODE SHOULD NOT ACTUALLY WORK
-- SERVES ONLY AS AN EXAMPLE OF FUNCTION USAGE

-- ON ERROR FUNCTIONS RETURN nil, status code, error message
-- ON SUCCESS FUNCTIONS RETURN the body
--   (you can choose between JSON and TABLE format with the decode flag)

local firebase = require 'firebase'

local firebase_pid = "example"
local path = "store"

-- this does a GET request to https://example.firebaseio.com/store.json
local jsondata = firebase.get(firebase_pid,path)

-- the data is returned in JSON format by default
print(jsondata)

-- if you set the decode flag to true (argument #3)
-- then you get a Lua table
local tabledata = firebase.get(firebase_pid,path,true)

-- if you have some data which is protected from reading without a TOKEN
-- then you need to pass the user TOKEN as an additional argument
local protected_path = "protected"
local token = "TOKEN_HERE"

-- this does a GET request to https://example.firebaseio.com/protected.json?access_token=TOKEN_HERE
local protecteddata = firebase.get(firebase_pid,protected_path,false,token)

-- some new data to be uploaded to Firebase DB
local new_data = {
  a=5,
  b="abc"
}

-- to post some data do a POST request
firebase.post(firebase_pid,"some/path/here",new_data,true,token)

-- new_data is a lua table so the encode flag has to be true
-- for it to get encoded into JSON

-- lets say that writing to the database is protected at the path some/path/here
-- that is why there is an user TOKEN as the last argument to the function
