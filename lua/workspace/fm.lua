local std = require "libs/std"
local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Tree Region ####################

if bindings.executable("ranger") then
  local tree = function ()

    local ranger1 = " --cmd='set preview_files=true'"
    local ranger2 = " --cmd='set use_preview_script=true'"
    local ranger = "ranger" .. ranger1 .. ranger2

    -- keybindings
    bindings.map.normal("<Leader>y", ":FloatermNew " .. ranger .. "<CR>")

  end
  registry.defer(tree)
end


if bindings.has("nvim") then

end
