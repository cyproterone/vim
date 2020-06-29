--#################### ############### ####################
--#################### Registry Region ####################
--#################### ############### ####################
local a = require "libs/async"
local bindings = require "libs/bindings"
local loop = require "libs/loop"
local std = require "libs/std"


local _registry = "libs/registry"
local vim_plug_remote = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
local vim_plug = vim_home .. "/autoload/plug.vim"
local plugin_home = vars_home .. "/vim_modules"
local pip_home = vars_home .. "/pip_modules"
local npm_home = vars_home .. "/node_modules"

local curl_args = {"--location", "--create-dirs", "--output", vim_plug, "--", vim_plug_remote}
local pip_args = {"install", "--upgrade", "--target", pip_home, "--", "pynvim"}


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
  if fn.filereadable(vim_plug) == 0 then
    local rpc = function (cb)
      local on_exit = {on_exit = "InstallRPC"}
      lv.cont_init_rpc = cb
      bindings.exec[[function! InstallRPC (job_id, code, event_type)
        lua lv.cont_init_rpc()
      endfunction]]
      fn.termopen(std.concat{{"pip3"}, pip_args}, on_exit)
    end
    local plug = function (cb)
      local on_exit = {on_exit = "InstallPlug"}
      lv.cont_init_plug = cb
      bindings.exec[[function! InstallPlug (job_id, code, event_type)
        lua lv.cont_init_plug()
      endfunction]]
      fn.termopen(std.concat{{"curl"}, curl_args}, on_exit)
    end
    a.sync(function ()
      a.wait_all{rpc, plug}
      cont(false)
    end)()
  else
    cont(true)
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

  fn["plug#begin"](plugin_home)
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


local normal = function (post)
  local inst = a.wait(init_plug)
  init_plugins()
  if inst then
    init_defer()
    post()
  else
    bindings.source(vim_plug)
    bindings.exec[[PlugInstall]]
  end
end


-- run in daemon mode
local scripted = function ()
  local plugins = std.map(_plugins, function (plug)
    return std.wrap(plug)[1]
  end)
  a.sync(function ()
    local args = {args = curl_args}
    local code = a.wait(loop.spawn("curl", args))
    if code ~= 0 then
      os.exit(code)
    end

    local args = {args = pip_args}
    local code = a.wait(loop.spawn("pip3", args))
    if code ~= 0 then
      os.exit(code)
    end

    local stream = table.concat(plugins, "\n")
    local args = {args = {plugin_home}, stream = stream}
    local code = a.wait(loop.spawn("git-package", args))
    if code ~= 0 then
      os.exit(code)
    end

    a.wait(loop.main)
    bindings.exec[[quitall]]
  end)()
end


local paths = function ()
  env["PATH"] = vim_home .. "/bin:"  .. env["PATH"]
  env["PATH"] = pip_home .. "/bin:"  .. env["PATH"]
  env["PATH"] = npm_home .. "/.bin:" .. env["PATH"]

  if env["PYTHONPATH"] then
    env["PYTHONPATH"] =  pip_home .. ":" .. env["PYTHONPATH"]
  else
    env["PYTHONPATH"] = pip_home
  end
end


local materialize = function (post)
  paths()
  a.sync(function ()
    if env["VIM_INIT"] then
      scripted()
    else
      normal(post)
    end
  end)()
end


return {
  install = install,
  defer = defer,
  const = _consts,
  auto = auto,
  materialize = materialize,
  call = call,
}
