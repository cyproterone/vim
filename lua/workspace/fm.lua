local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### File Manager Region ####################

-- ranger fm
table.insert(plugins, "rbgrouleff/bclose.vim")
table.insert(plugins, "francoiscabrol/ranger.vim")
local ranger = function ()

  -- dont add hotkeys
  bindings.let("ranger_map_keys", false)

  -- nerdtree integration
  bindings.let("NERDTreeHijackNetrw", false)

  -- replace netrw
  bindings.let("ranger_replace_netrw", true)


  -- key bind
  bindings.map.normal("<Leader>g", ":RangerWorkingDirectory<CR>")

end
table.insert(defer, ranger)


return {
  plugins = plugins,
  defer = defer,
}
