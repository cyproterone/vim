local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Whitespace Region ####################

local tab_size = function ()
  bindings.set("shiftwidth", 4)
  bindings.set("tabstop", 4)
  bindings.set("softtabstop", 4)
end
table.insert(defer, tab_size)


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

  -- dont ask dont tell
  bindings.let("strip_whitespace_confirm", 0)

end
table.insert(defer, trailing_whitespace)


return {
  plugins = plugins,
  defer = defer,
}
