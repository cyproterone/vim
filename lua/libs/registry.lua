--#################### ############### ####################
--#################### Registry Region ####################
--#################### ############### ####################
local a = require "libs/async"
local bindings = require "libs/bindings"
local loop = require "libs/loop"
local std = require "libs/std"
local stdio = require "libs/io"


local _registry = "libs/registry"
local vim_plug_remote = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
local vim_plug = vim_home .. "/plug.vim"
local plugin_dir = vim_home .. "/plugged"


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


local auto = function (events, func, filter, modifiers)

  local evnts = std.wrap(events)
  local events = table.concat(evnts, ",")
  local filter = table.concat(std.wrap(filter or "*"), ",")
  local modifiers = " " .. table.concat(std.wrap(modifiers or {}), " ")
  local idx = inc()
  local group = "augroup " .. idx
  local cls = "autocmd!"
  local cmd = "autocmd " .. events .. " " .. filter .. modifiers .. " lua require('" .. _registry .. "').call(" .. idx .. ")"
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
  lv.cont_init = function (inst)
    bindings.source(vim_plug)
    cont(inst)
  end
  bindings.exec[[function! InstallVimPlug (job_id, code, event_type)
    lua lv.cont_init()
  endfunction]]
  if not stdio.file_exists(vim_plug) then
    local on_exit = {on_exit = "InstallVimPlug"}
    fn.termopen({"curl", "--create-dirs", "-o", vim_plug, vim_plug_remote}, on_exit)
  else
    lv.cont_init(true)
  end
end


local init_plugins = function ()
  local plug = function (p)
    local args = std.wrap(p)
    local name = assert(args[1])
    local opts = std.exclude(args, {1})
    opts[true] = vim.types.dictionary
    fn["plug#"](name, opts)
  end

  fn["plug#begin"](plugin_dir)
  for _, plugin in ipairs(_plugins) do
    plug(plugin)
  end
  fn["plug#end"]()

  _plugins = {}
end


local init_defer = function ()
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
  for _, cmd in ipairs(_defer) do
    cmd()
  end
  _defer = {}
end


local normal = function ()
  local inst = a.wait(init_plug)
  init_plugins()
  if inst then
    init_defer()
  else
    bindings.exec[[PlugInstall]]
  end
end


-- run in daemon mode
local scripted = function ()
  local plugins = std.map(_plugins, function (plug)
    return std.wrap(plug)[1]
  end)
  a.sync(function ()
    local args = {args = {"--create-dirs", "-o", vim_plug, vim_plug_remote}}
    local code = a.wait(loop.spawn("curl", args))
    if code ~= 0 then
      os.exit(code)
    end

    local stream = table.concat(plugins, "\n")
    local args = {args = {plugin_dir}, stream = stream}
    local code = a.wait(loop.spawn("git-package", args))
    if code ~= 0 then
      os.exit(code)
    end

    os.exit(0)
  end)()
end


local materialize = a.sync(function ()
  env["PATH"] = vim_home .. "/bin:" .. env["PATH"]
  if env["VIM_INIT"] then
    scripted()
  else
    normal()
  end
end)


return {
  install = install,
  defer = defer,
  const = _consts,
  auto = auto,
  materialize = materialize,
  call = call,
}

