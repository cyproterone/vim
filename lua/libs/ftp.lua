--#################### ########## ####################
--#################### FTP Region ####################
--#################### ########## ####################

local set = require "libs/set"
local registry = require "libs/registry"

local _ftp = set.new()


local defer = function (ft, ftplugin)
  local ftp = function ()
    if set.contains(_ftp, ftplugin) then
      return
    end
    set.add(_ftp, ftplugin)
    ftplugin()
    print("-- LSP 加载: " .. table.concat(ft, ",") .. " --")
  end
  registry.auto("FileType", ftp, ft)
end


return {
  defer = defer
}
