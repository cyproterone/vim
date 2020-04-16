--#################### ########### ####################
--#################### Libs Region ####################
--#################### ########### ####################

require "libs/set"


--#################### ################ ####################
--#################### Workspace Region ####################
--#################### ################ ####################

require "workspace/keyboard"
require "workspace/misc"
require "workspace/navigation"
require "workspace/tasks"
require "workspace/theme"
require "workspace/tree"


--#################### ################# ####################
--#################### Versioning Region ####################
--#################### ################# ####################

require "versioning/git"


--#################### ############# ####################
--#################### Editor Region ####################
--#################### ############# ####################

require "editor/highlight"
require "editor/search"
require "editor/suggestions"


local actions = {
  keyboard(),
  misc(),
  navigation(),
  tasks(),
  themes(),
  tree(),
  git(),
  highlight(),
  search(),
  suggestions()
}


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

    vim.api.command(cmd)
  end

end


local initialize_vim = function ()
  local instructions = parse_instructions(actions)
  install_plugins(instructions.plugins)
  execute_commands(instructions.commands)
end
