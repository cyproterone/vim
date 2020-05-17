--#################### ########## ####################
--#################### FTP Region ####################
--#################### ########## ####################

local std = require "libs/std"
local set = require "libs/set"
local registry = require "libs/registry"

local _init = {}
local _ftp = {}


local defer = function (defer)
  registry.defer(defer)
end


return {
  defer = defer
}
