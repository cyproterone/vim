local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Whitespace Region ####################

local unsurprising_tab = function ()

  -- insert spaces instead of tabs
  bindings.set("expandtab")

  -- smart indentation level
  bindings.set("autoindent")
  bindings.set("smarttab")

end
table.insert(defer, unsurprising_tab)


-- remove trailing whitespace
table.insert(plugins, "ntpeters/vim-better-whitespace")
local trailing_whitespace = function ()

  -- strip whitespace
  bindings.let("strip_whitespace_on_save", 1)

  -- highlight whitespace
  bindings.let("better_whitespace_enabled", 1)

  -- highlight mixed whitespace
  bindings.let("show_spaces_that_precede_tabs", 1)

end


return {
  plugins = plugins,
  defer = defer,
}
