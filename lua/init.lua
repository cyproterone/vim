--#################### Libs Region ####################
require "libs/consts"
local std = require "libs/std"
local stdio = require "libs/io"
local bindings = require "libs/bindings"


local layers = {
  -- workspace
  require "workspace/fm",
  require "workspace/help",
  require "workspace/keyboard",
  require "workspace/misc",
  require "workspace/mouse",
  require "workspace/navigation",
  require "workspace/proj",
  require "workspace/tasks",
  require "workspace/theme",
  require "workspace/tree",
  require "workspace/wm",
  -- modes
  require "modes/command",
  require "modes/ex",
  require "modes/insert",
  require "modes/normal",
  require "modes/multi",
  -- versioning
  require "versioning/git",
  -- editor
  require "editor/cursors",
  require "editor/format",
  require "editor/highlight",
  require "editor/lsp",
  require "editor/macros",
  require "editor/repl",
  require "editor/search",
  require "editor/suggestions",
  require "editor/whitespace",
  -- lang
  require "lang/json"
}


--#################### Init Region ####################

local parse_instructions = function (layers)

  local plugins = {}
  local defer = {}

  for _, instructions in ipairs(layers)
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

local init_plug = function ()

  local remote = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  local plug = bin_home .. "/plug.vim"
  local exists = stdio.file_exists(plug)
  if not exists
  then
      stdio.exec("wget -P " .. bin_home  .. " " .. remote)
  end
  bindings.source(plug)

end

local init_plugins = function (plugins)

  local plug = function (p)
    local args = std.wrap(p)
    local name = assert(args[1])
    local opts = std.exclude(args, {1})
    return "Plug '" .. name .. "' , " .. bindings.p_val(opts)
  end

  local plug_lines = std.map(plugins, plug)
  local plug_installs = table.concat(plug_lines, "\n")

  local plug_beign = "call plug#begin('" .. vim_home .. "/plugged" .. "')"
  local plug_end = "call plug#end()"
  local install_func = table.concat({plug_beign, plug_installs, plug_end}, "\n")

  bindings.arbitrary(install_func)
end


local execute_defered = function (defer)
  bindings.let("mapleader", " ")
  for _, cmd in ipairs(defer)
  do
    cmd()
  end
end


local initialize_vim = function ()
  local instructions = parse_instructions(layers)
  init_plug()
  init_plugins(instructions.plugins)
  execute_defered(instructions.defer)
end


initialize_vim()
