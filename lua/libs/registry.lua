--#################### ############### ####################
--#################### Registry Region ####################
--#################### ############### ####################

local std = require "libs/std"
local stdio = require "libs/io"
local bindings = require "libs/bindings"


local _registry = "libs/registry"

local _plugins = {}
local _defer = {}
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
  local filter = table.concat(std.wrap(filter or "*"), " ")
  local idx = inc()
  local group = "augroup " .. idx
  local cls = "autocmd!"
  local cmd = "autocmd " .. events .. " " .. filter .. " lua require('" .. _registry .. "').call(" .. idx .. ")"
  local done = "augroup END"

  for event in ipairs(evnts) do
    assert(fn.exists("##" .. event))
  end

  api.nvim_command(group)
  api.nvim_command(cls)
  api.nvim_command(cmd)
  api.nvim_command(done)

  _callbacks[idx] = func
  return function ()
    remove(idx)
  end
end


local init_plug = function ()
  local remote = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  local plug = bin_home .. "/plug.vim"
  local exists = fn.exists(plug)
  if not exists then
    stdio.exec("wget -P " .. bin_home  .. " " .. remote)
  end
  bindings.source(plug)
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
end


local init_defer = function ()
  bindings.let("mapleader", " ")
  for _, cmd in ipairs(_defer) do
    cmd()
  end
end


local materialize = function ()
  init_plug()
  init_plugins()
  init_defer()
end


return {
  install = install,
  defer = defer,
  auto = auto,
  materialize = materialize,
  call = call,
}
