--#################### ######### ####################
--#################### FS Region ####################
--#################### ######### ####################
local a = require "libs/async"
local uv = vim.loop


local join = function (paths)
  local sep = "/"
  local path = ""
  for _, p in ipairs(paths) do
    path = path .. sep .. p
  end
  return path
end


local realpath = function (path)
  return a.sync(function ()
    a.wait(function (cb)
      uv.fs_realpath(path, function (err, p)
        assert(not err, err)
        cb(p)
      end)
    end)
  end)
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

    local coll = a.wait(function (cb)
      uv.fs_readdir(handle, function (err, tb)
        assert(not err, err)
        local coll = {}
        for _, el in ipairs(tb) do
          local c = coll[el.type] or {}
          table.insert(c, el.name)
          coll[el.type] = c
        end
        cb(coll)
      end)
    end)

    a.wait(function (cb)
      uv.fs_closedir(handle, function (err, succ)
        assert(not err and succ, err)
        cb()
      end)
    end)

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
  join = join,
  realpath = realpath,
  read_dir = read_dir,
  move = move,
  copy = copy,
}
