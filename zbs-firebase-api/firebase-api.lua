
-- firebase autocomplete for ZeroBrane studio
-- Author: Rok Fajfar

return {
  firebase = {
    type = "lib",
    description = "Firebase REST API for lua",
    childs = {
      get = {
        args = "(path: string, do_decoding: boolean)",
        description = "GET request for FIREBASE",
        returns = "string or table",
        type = "method"
      },
      set = {
        args = "(path : string, data : table | value)",
        description = "PUT request on path",
        returns = "()",
        type = "method"
      },
      put = {
        args = "(path : string, data : table | value)",
        description = "PUT request on path",
        returns = "()",
        type = "method"
      },
      push = {
        args = "(path : string, data : table | value)",
        description = "POST request on path",
        returns = "()",
        type = "method"
      },
      post = {
        args = "(path : string, data : table | value)",
        description = "POST request on path",
        returns = "()",
        type = "method"
      },
      encode = {
        args = "(data : table)",
        description = "encode table to JSON string",
        returns = "(string)",
        type = "method"
      },
      decode = {
        args = "(json_string : string)",
        description = "decode JSON string to table",
        returns = "(table)",
        type = "method"
      },
      init = {
        args = "(root_url : string)",
        description = "set the root url that firebase will be using",
        returns = "()",
        type = "method"
      },
      delete = {
        args = "(path : string)",
        description = "DELETE request on path",
        returns = "()",
        type = "method"
      },
      remove = {
        args = "(path : string)",
        description = "DELETE request on path",
        returns = "()",
        type = "method"
      },
      download = {
        args = "(path : string, filename : string)",
        description = "download data on path to file in JSON format",
        returns = "()",
        type = "method"
      },
      }
    }
}
