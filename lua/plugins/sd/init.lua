--#################### ########### ####################
--#################### Main Region ####################
--#################### ########### ####################

local std = require "libs/std"
local a = require "libs/async"
local s = require "libs/string"
local set = require "libs/set"
local loop = require "plugins/sd/libs/loop"
local shell = require "plugins/sd/shell"
local buffers = require "plugins/sd/buffers"
local windows = require "plugins/sd/windows"


local find_files = function (pattern)
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



local assemble = function ()
  api.nvim_win_set_buf(win_s, sidebar)
  api.nvim_win_set_buf(win_m, main)
end



local preview = function (args, file)
  local flags = std.concat({args.flags, {"-p"}})
  local sd_args = {flags = flags, 
                   pattern = args.pattern,
                   replacement = args.replacement,
                   file = file,}

  return a.sync(function () 
    local sd_preview = a.wait(shell.sd(sd_args))
    local diff = a.wait(shell.diff(file, sd_preview))
    return diff
  end)
end


local replace = function (args, file)
  local sd_args = {flags = flags, 
                   pattern = args.pattern,
                   replacement = args.replacement,
                   file = file,}

  return a.sync(function () 
    a.wait(shell.sd(sd_args))
  end)
end


local main = function (args)
  local sd_flags = set.new(assert(args.sd_flags))
  local fd_pattern = assert(args.fd_pattern)
  local sd_pattern = assert(args.sd_pattern)
  local sd_replace = assert(args.sd_replace)
  set.subtract(sd_flags, "-p")
  local flags = std.keys(sd_flags)
  local sd_args = {flags = flags,
                   pattern = sd_pattern,
                   replacement = sd_replace}

  return a.sync(function ()
    api.nvim_command[[silent wa]]
    local files = a.wait(find_files(fd_pattern))
    local previews = a.wait(std.map(files, function (file)
      return preview(sd_args, file)
    end))
    a.wait(loop.main)
  end)
end


main({ sd_flags = {}, fd_pattern = ".lua", sd_pattern = "local", sd_replace = "uwu" })()
