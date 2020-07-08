local a = require "libs/async"
local fs = require "libs/fs"


local read_tree = function (root, depth)
  local rt = function (root, d)
    print(root)
    return a.sync(function ()
      local ret = {files = {}, children = {}}
      if d > depth then
        return nil
      else
        local raw = a.wait(fs.read_dir(root))
        ret.files = raw.file or {}
        return ret
      end
    end)
  end
  return rt(root, depth)
end


a.sync(function ()
  local things = a.wait(read_tree(fs.cwd(), 1))
  print(vim.inspect(things))
end)()
