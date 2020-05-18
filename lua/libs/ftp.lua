--#################### ########## ####################
--#################### FTP Region ####################
--#################### ########## ####################

local set = require "libs/set"
local registry = require "libs/registry"

local _ftp = set.new()


local defer = function (ft, ftplugin)
  set.add(_ftp, ftplugin)
  local ftp = function (kill)
    if not set.contains(_ftp, ftplugin) then
      return
    end
    set.subtract(_ftp, ftplugin)
    ftplugin()
    kill()
    print("-- LSP 加载: " .. table.concat(ft, ",") .. " --")
  end
  registry.auto("FileType", ftp, ft)
end


local always = function (ft, ftplugin)
  registry.auto({"FileType", buffer = true}, ftplugin, ft)
end


return {
  defer = defer,
  always = always,
}
