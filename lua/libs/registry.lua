--#################### ############### ####################
--#################### Registry Region ####################
--#################### ############### ####################


local _plugins = {}
local _defer = {}
local _autocmds = {}


local install function (p)
  table.insert(_plugins, p)
end


local defer = function (d)
  table.insert(_defer, d)
end


local auto = function (f)
  table.insert(_autocmds, f)
end


local materialize = function ()

end


return {
  install = install,
  defer = defer,
  auto = auto,
  materialize = materialize,
}
