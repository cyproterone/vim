require "libs/set"


git = function ()

  local plugins = {}
  local defer = {}

  --#################### Git Region ####################

  -- gitgutter
  table.insert(plugins, "airblade/vim-gitgutter")

  -- view git history
  table.insert(plugins, "junegunn/gv.vim")

  -- git porcelain
  table.insert(plugins, "tpope/vim-fugitive")


  return {
    plugins = plugins,
    defer = defer,
  }
end
