local a = require "libs/async"
local fs = require "libs/fs"



a.sync(function ()
  local things = a.wait(fs.read_dir("."))
  print(vim.inspect(things))
end)()
