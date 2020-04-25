local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### JSON Region ####################

local lang = function ()

  bindings.auto{
    group = "lang_json",
    events = "FileType",
    filter = "json",
    exec = [[syntax match Comment +\/\/.\+$+]]}

end
table.insert(defer, lang)


return {
  plugins = plugins,
  defer = defer,
}
