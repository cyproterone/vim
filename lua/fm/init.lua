local a = require "libs/async"
local fs = require "libs/fs"


local read_tree = function (root, depth)
  local rt = function (root, d)
    return a.sync(function ()
      local ret = {}
      if d > depth then
        return ret
      else
        local contents = a.wait(fs.read_dir(root))
        return contents
      end
    end)
  end
  return rt(root, depth)
end


a.sync(function ()
  local things = a.wait(read_tree(fs.cwd()))
  print(vim.inspect(things))
end)()
