--#################### ########### ####################
--#################### Libs Region ####################
--#################### ########### ####################

require "libs/set"


--#################### ################ ####################
--#################### Workspace Region ####################
--#################### ################ ####################

require "workspace/keyboard"
require "workspace/misc"
require "workspace/mouse"
require "workspace/navigation"
require "workspace/tasks"
require "workspace/theme"
require "workspace/tree"
require "workspace/wm"


--#################### ################# ####################
--#################### Versioning Region ####################
--#################### ################# ####################

require "versioning/git"


--#################### ############# ####################
--#################### Editor Region ####################
--#################### ############# ####################

require "editor/cursors"
require "editor/highlight"
require "editor/macros"
require "editor/search"
require "editor/suggestions"
require "editor/whitespace"


--#################### END ####################

local actions = {
  -- workspace
  keyboard(),
  mouse(),
  misc(),
  navigation(),
  tasks(),
  themes(),
  tree(),
  wm(),
  -- versioning
  git(),
  -- editor
  cursors(),
  highlight(),
  macros(),
  search(),
  suggestions(),
  whitespace()
}


--#################### ########### ####################
--#################### Init Region ####################
--#################### ########### ####################

local parse_instructions = function (actions)

  local plugins = {}
  local commands = {}

  for _, instructions in ipairs(actions)
  do

    for _, plugin in ipairs(instructions.plugins)
    do
      table.insert(plugins, plugin)
    end


    for _, cmd in ipairs(instructions.commands)
    do
      table.insert(commands, cmd)
    end

  end

  return {
    plugins = plugins,
    commands = commands
  }
end


local install_plugins = function (plugins)

  for _, plugin in ipairs(plugins)
  do

  end

end


local execute_commands = function (commands)

  for _, cmd in ipairs(commands)
  do
    vim.api.nvim_command(cmd)
  end

end


local initialize_vim = function ()
  local instructions = parse_instructions(actions)
  install_plugins(instructions.plugins)
  execute_commands(instructions.commands)
end


initialize_vim()
