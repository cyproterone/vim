--#################### ############ ####################
--#################### Shell Region ####################
--#################### ############ ####################

local std = require "libs/std"
local s = require "libs/string"
local a = require "libs/async"
local loop = require "plugins/sd/libs/loop"
local uv = vim.loop
local spawn = a.wrap(loop.spawn)


local fd = function (pattern)
  local fd_args = {"-H", "-L", "-0", "--type=f"} 
  table.insert(fd_args, pattern)
  local opts = {args = fd_args}

  return a.sync(function ()
    local ret = a.wait(spawn("fd", opts))
    assert(ret.code == 0, ret.err)
    local files = s.split(0, ret.out) 
    return files 
  end)
end


local sd = function (args)
  local flags = assert(args.flags)
  local pattern = assert(args.pattern)
  local replacement = assert(args.replacement)
  
  local sd_args = flags
  table.insert(sd_args, pattern)
  table.insert(sd_args, replacement)
  local opts = {args = sd_args}

  if args.file then
    table.insert(sd_args, args.file)
  else
    opts.stream = assert(args.content)
  end
  
  return a.sync(function ()
    local ret = a.wait(spawn("sd", opts))
    assert(ret.code == 0, ret.err)
    return ret.out
  end)
end


local diff = function (before, after)
  local args = {"--suppress-common-lines",
                "--width=9999",
                before, 
                after}
  local opts = {args = args}

  return a.sync(function ()
    local ret = a.wait(spawn("diff", opts))
    assert(ret.code ~= 2, ret.err)
    return ret.out
  end)
end


local mktmp = function (data, mode)
  local mode = mode or 660
  local tmp = assert(uv.os_tmpdir()) .. "/sd_vimXXXXXXXXXXXXXXX"
  return a.sync(function ()
    local ret = a.wait(spawn("mktemp", {}))
    assert(ret.code == 0, ret.err)
    local path = s.trim(string.byte("\n"), ret.out)
    local err, fd = a.wait(a.wrap(uv.fs_open)(path, "w+", mode))
    assert(not err, err)
    local err = a.wait(a.wrap(uv.fs_write)(fd, data, 0))
    assert(not err, err)
    local err = a.wait(a.wrap(uv.fs_close)(fd))
    assert(not err, err)
    return path
  end)
end


return {
  fd = fd,
  sd = sd,
  diff = diff,
  mktmp = mktmp,
}

