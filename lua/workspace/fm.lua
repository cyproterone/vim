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
    bindings.map.normal("<Leader>y", ":RnvimrToggle<CR>")

  end
  registry.defer(tree)
end


if bindings.has("nvim") then

  registry.install{"Shougo/defx.nvim", ["do"] = ":UpdateRemotePlugins"}
  registry.install("kristijanhusak/defx-icons")
  registry.install("kristijanhusak/defx-git")

  local keymap = function (buf)
    local opts = {expr = true, buffer = buf}

    bindings.map.normal("q",       "defx#do_action('quit')",                     opts)

    bindings.map.normal("<Tab>",   "defx#do_action('open_tree', 'toggle')",      opts)
    bindings.map.normal("<Up>",    "line('.') == 1 ? 'G' : '<Up>'",              opts)
    bindings.map.normal("<Down>",  "line('.') == line('$') ? 'gg' : '<Down>'",   opts)
    bindings.map.normal("<Right>", "defx#do_action('open')",                     opts)
    bindings.map.normal("<Left>",  "defx#do_action('cd', ['..'])",               opts)
    bindings.map.normal("~",       "defx#do_action('cd')",                       opts)
    bindings.map.normal("cd",      "defx#do_action('change_vim_cwd')",           opts)
    bindings.map.normal(".",       "defx#do_action('toggle_ignored_files')",     opts)

    bindings.map.normal("<Space>", "defx#do_action('toggle_select') . '<Down>'", opts)
    bindings.map.normal("*",       "defx#do_action('toggle_select_all')",        opts)
    bindings.map.normal("y",       "defx#do_action('copy')",                     opts)
    bindings.map.normal("p",       "defx#do_action('paste')",                    opts)
    bindings.map.normal("r",       "defx#do_action('rename')",                   opts)
    bindings.map.normal("m",       "defx#do_action('move')",                     opts)
    bindings.map.normal("d",       "defx#do_action('remove')",                   opts)
    bindings.map.normal("!",       "defx#do_action('execute_command')",          opts)
    bindings.map.normal("x",       "defx#do_action('execute_system')",           opts)
    bindings.map.normal(";",       "defx#do_action('repeat')",                   opts)

    bindings.map.normal("n",       "defx#do_action('new_file')",                 opts)
    bindings.map.normal("N",       "defx#do_action('new_multiple_files')",       opts)
    bindings.map.normal("m",       "defx#do_action('new_directory')",            opts)

    bindings.map.normal("e",       "defx#do_action('open', 'vsplit')",           opts)
    bindings.map.normal("E",       "defx#do_action('open', 'pedit')",            opts)


    bindings.map.normal("<C-l>",   "defx#do_action('redraw')",                   opts)
    bindings.map.normal("<C-g>",   "defx#do_action('print')",                    opts)

    bindings.map.normal("C", "defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')", opts)

  end
  registry.auto("FileType", keymap, "defx")

  local options = function ()

    bindings.map.normal("<Leader>i", ":Defx<Cr>")

  end
  registry.defer(options)

end
