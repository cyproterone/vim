--#################### Libs Region ####################
require "libs/consts"
require "libs/set"


--#################### Workspace Region ####################
require "workspace/keyboard"
require "workspace/misc"
require "workspace/mouse"
require "workspace/navigation"
require "workspace/proj"
require "workspace/tasks"
require "workspace/theme"
require "workspace/tree"
require "workspace/wm"


--#################### Versioning Region ####################
require "versioning/git"


--#################### Editor Region ####################
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
  proj(),
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


--#################### Init Region ####################

local parse_instructions = function (actions)

  local plugins = {}
  local defer = {}

  for _, instructions in ipairs(actions)
  do

    for _, plugin in ipairs(instructions.plugins)
    do
      table.insert(plugins, plugin)
    end


    for _, cmd in ipairs(instructions.defer)
    do
      table.insert(defer, cmd)
    end

  end

  return {
    plugins = plugins,
    defer = defer,
  }
end


local install_plugins = function (plugins)

  for _, plugin in ipairs(plugins)
  do

  end

end


local execute_defer = function (defer)

  for _, cmd in ipairs(defer)
  do
    cmd()
  end

end


local initialize_vim = function ()
  local instructions = parse_instructions(actions)
  install_plugins(instructions.plugins)
  execute_defer(instructions.defer)
end


initialize_vim()
