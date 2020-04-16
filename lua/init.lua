--#################### Libs Region ####################
local std = require "libs/std"
require "libs/consts"


local actions = {
  -- workspace
  require "workspace/keyboard",
  require "workspace/misc",
  require "workspace/mouse",
  require "workspace/navigation",
  require "workspace/proj",
  require "workspace/tasks",
  require "workspace/theme",
  require "workspace/tree",
  require "workspace/wm",
  -- versioning
  require "versioning/git",
  -- editor
  require "editor/cursors",
  require "editor/highlight",
  require "editor/macros",
  require "editor/search",
  require "editor/suggestions",
  require "editor/whitespace",
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
  local plug = function (p)
    return "Plug '" .. p .. "'"
  end

  local plug_lines = std.map(plugins, plug)
  local plug_installs = table.concat(plug_lines, "\n")

  local plug_beign = "call plug#begin('" .. vim_home .. "/plugged" .. "')"
  local plug_end = "call plug#end()"
  local install_func = table.concat({plug_beign, plug_installs, plug_end}, "\n")

  api.nvim_command(install_func)
end


local execute_defered = function (defer)
  for _, cmd in ipairs(defer)
  do
    cmd()
  end
end


local initialize_vim = function ()
  local instructions = parse_instructions(actions)
  install_plugins(instructions.plugins)
  execute_defered(instructions.defer)
end


initialize_vim()
