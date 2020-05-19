local std = require "libs/std"
local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### File Manager Region ####################

if bindings.executable("ranger") then

  registry.install{"kevinhwang91/rnvimr", ["do"] = "make sync"}
  local tree = function ()

    -- preview on root
    local ranger1 = " --cmd='set preview_files=true'"
    local ranger2 = " --cmd='set use_preview_script=true'"
    local ranger = "ranger" .. ranger1 .. ranger2
    bindings.let("rnvimr_ranger_cmd", ranger)


    -- replace netrw
    bindings.let("rnvimr_ex_enable", true)
    -- wipe deleted buf
    bindings.let("rnvimr_bw_enable", true)


    -- keybindings
    bindings.map.normal("<Leader>i", ":RnvimrToggle<CR>")

  end
  registry.defer(tree)
end


if bindings.has("nvim") then

end
