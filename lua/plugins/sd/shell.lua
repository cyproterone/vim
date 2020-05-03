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
  
  local sd_args = std.concat{flags}
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


local mktemp = function (template)
  local args = std.wrap(template)
  return a.sync(function () 
    local ret = a.wait(spawn("mktemp", {args=args}))
    assert(ret.code == 0, ret.err)
    local path = s.trim(string.byte("\n"), ret.out)
    return path
  end)
end


local mktmp = function (data, mode)
  local mode = mode or 660
  local tmp = assert(uv.os_tmpdir()) .. "/sd_vimXXXXXXXXXXXXXXX"
  return a.sync(function ()
    local path = a.wait(mktemp())
    local err, fd = a.wait(a.wrap(uv.fs_open)(path, "w+", mode))
    assert(not err, err)
    local err = a.wait(a.wrap(uv.fs_write)(fd, data, 0))
    assert(not err, err)
    local err = a.wait(a.wrap(uv.fs_close)(fd))
    assert(not err, err)
    return path
  end)
end


local replace = function (target, replacement)
  return a.sync(function ()
    local err, stat = a.wait(a.wrap(uv.fs_stat)(target))
    assert(not err, err)

    local backup = a.wait(mktemp(target .. "_sd_vim_XXXXXXXXX"))
    local err, succ = a.wait(a.wrap(uv.fs_rename)(target, backup))
    assert(not err, err)

    local err, succ = a.wait(a.wrap(uv.fs_rename)(replacement, target))
    assert(not err and succ, err)
    local err, succ = a.wait(a.wrap(uv.fs_chmod)(target, stat.mode))
    assert(not err and succ, err)
    local err, succ = a.wait(a.wrap(uv.fs_chown)(target, stat.uid, stat.gid))
    assert(not err and succ, err)

    local err, succ = a.wait(a.wrap(uv.fs_unlink)(backup))
    assert(not err and succ, err)
  end)
end


return {
  fd = fd,
  sd = sd,
  diff = diff,
  mktmp = mktmp,
  replace = replace,
}

