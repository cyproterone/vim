--#################### ######### ####################
--#################### FS Region ####################
--#################### ######### ####################
local a = require "libs/async"
local uv = vim.loop


local read_dir = function(path)
  local t31 = 1048576

  return a.sync(function ()
    local handle = a.wait(function (cb)
      uv.fs_opendir(path, function (err, dir)
        assert(not err, err)
        cb(dir)
      end, t31)
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



return {
  read_dir = read_dir
}
