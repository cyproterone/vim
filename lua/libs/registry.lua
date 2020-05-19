--#################### ############### ####################
--#################### Registry Region ####################
--#################### ############### ####################

local std = require "libs/std"
local a = require "libs/async"
local stdio = require "libs/io"
local bindings = require "libs/bindings"


local _registry = "libs/registry"

local _plugins = {}
local _defer = {}
local _consts = {}
local _callbacks = {}
local inc = std.count()


local install = function (p)
  table.insert(_plugins, p)
end


local defer = function (d)
  table.insert(_defer, d)
end


local remove = function (idx)
  local clear = "autocmd! " .. idx
  _callbacks[idx] = nil
  api.nvim_command(clear)
end


local call = function (idx, ...)
  local kill = function ()
    remove(idx)
  end
  _callbacks[idx](kill, ...)
end


local auto = function (events, func, filter)

  local evnts = std.wrap(events)
  local events = table.concat(evnts, ",")
  local filter = table.concat(std.wrap(filter or "*"), ",")
  local idx = inc()
  local group = "augroup " .. idx
  local cls = "autocmd!"
  local cmd = "autocmd " .. events .. " " .. filter .. " lua require('" .. _registry .. "').call(" .. idx .. ")"
  local done = "augroup END"

  for event in ipairs(evnts) do
    assert(fn.exists("##" .. event))
  end

  _callbacks[idx] = func
  api.nvim_command(group)
  api.nvim_command(cls)
  api.nvim_command(cmd)
  api.nvim_command(done)

  return function ()
    remove(idx)
  end
end


local init_plug = function (cont)
  local remote = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  local plug = bin_home .. "/plug.vim"
  lua_cont_init = function ()
    bindings.source(plug)
    cont()
  end
  bindings.exec[[
  function! InstallVimPlug (job_id, code, event_type)
    v:lua.lua_cont_init()
  endfunction
  ]]
  if not stdio.file_exists(plug) then
    fn.termopen({"curl", "--create-dirs", "-o", plug, remote}, {on_exit = "InstallVimPlug"})
  else
    lua_cont_init()
  end
end


local init_plugins = function ()
  local plug = function (p)
    local args = std.wrap(p)
    local name = assert(args[1])
    local opts = std.exclude(args, {1})
    return "Plug '" .. name .. "' , " .. bindings.p_val(opts)
  end

  local plug_lines = std.map(_plugins, plug)
  local plug_installs = table.concat(plug_lines, "\n")

  local plug_beign = "call plug#begin('" .. vim_home .. "/plugged" .. "')"
  local plug_end = "call plug#end()"
  local install_func = table.concat({plug_beign, plug_installs, plug_end}, "\n")

  bindings.exec(install_func)
  _plugins = {}
end


local init_defer = function ()
  bindings.let("mapleader", " ")
  bindings.let("maplocalleader", " ")
  for _, cmd in ipairs(_defer) do
    cmd()
  end
  _defer = {}
end


local materialize = a.sync(function ()
  a.wait(init_plug)
  init_plugins()
  init_defer()
end)


return {
  install = install,
  defer = defer,
  const = _consts,
  auto = auto,
  materialize = materialize,
  call = call,
}
