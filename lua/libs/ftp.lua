--#################### ########## ####################
--#################### FTP Region ####################
--#################### ########## ####################

local std = require "libs/std"
local set = require "libs/set"
local registry = require "libs/registry"

local _ftp = set.new({})


local defer = function (ft, defer)
  local ftp = function ()
    if set.contains(_ftp, defer) then
      return
    end
    set.add(_ftp, defer)
    defer()
  end
  registry.auto("FileType", ftp, ft)
end


return {
  defer = defer
}
