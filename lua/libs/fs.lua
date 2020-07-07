--#################### ######### ####################
--#################### FS Region ####################
--#################### ######### ####################
local a = require "libs/async"
local std = require "libs/std"
local uv = vim.loop


local cwd = uv.cwd


local chdir = uv.chdir


local join = function (paths)
  local sep = "/"
  local path = ""
  for _, p in ipairs(paths) do
    path = path .. sep .. p
  end
  return path
end


local read_dir = function(path)
  local t20 = 1048576

  return a.sync(function ()
    local handle = a.wait(function (cb)
      uv.fs_opendir(path, function (err, dir)
        assert(not err, err)
        cb(dir)
      end, t20)
    end)

    local tb = a.wait(function (cb)
      uv.fs_readdir(handle, function (err, tb)
        assert(not err, err)
        cb(tb)
      end)
    end)

    a.wait(function (cb)
      uv.fs_closedir(handle, function (err, succ)
        assert(not err and succ, err)
        cb()
      end)
    end)

    local coll = {}
    for _, el in ipairs(tb) do
      local c = coll[el.type] or {}
      table.insert(c, el.name)
      coll[el.type] = c
    end

    local links = {a.wait_all(std.map(coll.link or {}, function (link)
      return function (cb)
        uv.fs_stat(link, function (err, stat)
          assert(not err, err)
          cb{type = stat.type, name = link}
        end)
      end
    end))}

    for _, link in ipairs(links) do
      local el = unpack(link)
      local c = coll[el.type] or {}
      table.insert(c, el.name)
      coll[el.type] = c
    end

    return coll
  end)
end


local move = function (src, dest)
  return a.sync(function ()
    a.wait(function (cb)
      uv.fs_rename(src, dest, nil, function (err, succ)
        assert(not err and succ, err)
        cb()
      end)
    end)
  end)
end


local copy = function (src, dest)
  return a.sync(function ()
    a.wait(function (cb)
      uv.fs_copyfile(src, dest, nil, function (err, succ)
        assert(not err and succ, err)
        cb()
      end)
    end)
  end)
end


return {
  cwd = cwd,
  chdir = chdir,
  join = join,
  read_dir = read_dir,
  move = move,
  copy = copy,
}
