require "libs/set"


git = function ()

  local commands = {}
  local plugins = {}

  --#################### Git Region ####################

  -- gitgutter
  table.insert(plugins, "airblade/vim-gitgutter")

  -- view git history
  table.insert(plugins, "junegunn/gv.vim")

  -- git porcelain
  table.insert(plugins, "tpope/vim-fugitive")

  return {
    commands = commands,
    plugins = plugins
  }
end
