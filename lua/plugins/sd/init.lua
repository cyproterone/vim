--#################### ########### ####################
--#################### Main Region ####################
--#################### ########### ####################

local std = require "libs/std"
local a = require "libs/async"
local s = require "libs/string"
local set = require "libs/set"
local loop = require "plugins/sd/libs/loop"
local cb = require "plugins/sd/libs/callbacks"
local shell = require "plugins/sd/shell"
local buffers = require "plugins/sd/buffers"
local windows = require "plugins/sd/windows"

local concurrency = sd_concurrency or 2


local fd = function (pattern)
  return a.sync(function () 
    if pattern == "" then
      local buf = api.nvim_get_current_buf() 
      local path = api.nvim_call_function("bufname", {buf})
      assert(path ~= "", "error :: need to save file first")
      return {path}
    else
      local files = a.wait(shell.fd(pattern))
      return files
    end
  end)
end


local sd = function (sd_args, file)
  local sd_args = std.merge{sd_args, {file = file}}
  return a.sync(function () 
    local sd_preview = a.wait(shell.sd(sd_args))
    local replace = a.wait(shell.mktmp(sd_preview))
    local dif = a.wait(shell.diff(file, replace))
    return replace, dif
  end)
end


local main = function (args)
  local sd_flags = assert(args.sd_flags)
  local fd_pattern = assert(args.fd_pattern)
  local sd_pattern = assert(args.sd_pattern)
  local sd_replace = assert(args.sd_replace)
  
  local flagset = set.new(sd_flags)
  set.add(flagset, "-p")
  local sd_args = {flags = std.keys(flagset),
                   pattern = sd_pattern,
                   replacement = sd_replace}

  return a.sync(function ()
    api.nvim_command[[silent wa]]
    local files = a.wait(fd(fd_pattern))
    local thunks = std.map(files, function (file)
      return sd(sd_args, file)
    end)
    local replacements = a.wait(cb.throttle(thunks, concurrency))
    end

    a.wait(loop.main)
  end)
end


main({ sd_flags = {}, fd_pattern = ".lua", sd_pattern = "local", sd_replace = "uwu" })()
