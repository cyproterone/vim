--#################### ########## ####################
--#################### Lua Region ####################
--#################### ########## ####################
local bindings = require "libs/bindings"
local fmt = require "libs/fmt"
local ftp = require "libs/ftp"


local shebang = {"#!/usr/bin/env swipl"}


ftp.shebang("prolog", shebang)
