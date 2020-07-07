local a = require "libs/async"
local fs = require "libs/fs"


local read_tree = function (root, depth)
  local rt = function (root, d)
    return a.sync(function ()
    end)
  end
  return rt(root, 0)
end

a.sync(function ()
  local things = a.wait(read_tree(fs.cwd()))
  print(vim.inspect(things))
end)()
