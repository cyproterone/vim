local std = require "libs/std"
local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### File Manager Region ####################

-- needs :UpdateRemotePlugins
registry.install("Shougo/defx.nvim")
registry.install("kristijanhusak/defx-icons")
registry.install("kristijanhusak/defx-git")
local keymap = function (buf)
  local opts = {expr = true, buffer = buf}
  local git_opts = {noremap = false, buffer = buf}

  bindings.map.normal("q",       "defx#async_action('quit')",                                     opts)

  bindings.map.normal("<Tab>",   "defx#async_action('open_tree', 'toggle')",                      opts)
  bindings.map.normal("o",       "defx#async_action('open_tree', ['toggle', 'recursive'])",       opts)
  bindings.map.normal("<Enter>", "defx#async_action('drop')",                                     opts)
  bindings.map.normal("<Up>",    "line('.') == 1 ? 'G' : '<Up>'",                                 opts)
  bindings.map.normal("<Down>",  "line('.') == line('$') ? 'gg' : '<Down>'",                      opts)
  bindings.map.normal("<Right>", "defx#async_action('drop')",                                     opts)
  bindings.map.normal("<Left>",  "defx#async_action('cd', ['..'])",                               opts)
  bindings.map.normal("~",       "defx#async_action('cd')",                                       opts)
  bindings.map.normal("cd",      "defx#async_action('change_vim_cwd')",                           opts)
  bindings.map.normal(".",       "defx#async_action('toggle_ignored_files')",                     opts)

  bindings.map.normal("<Space>", "defx#async_action('toggle_select')",                            opts)
  bindings.map.normal("*",       "defx#async_action('toggle_select_all')",                        opts)
  bindings.map.normal("y",       "defx#async_action('copy')",                                     opts)
  bindings.map.normal("p",       "defx#async_action('paste')",                                    opts)
  bindings.map.normal("r",       "defx#async_action('rename')",                                   opts)
  bindings.map.normal("m",       "defx#async_action('move')",                                     opts)
  bindings.map.normal("d",       "defx#async_action('remove')",                                   opts)
  bindings.map.normal("!",       "defx#async_action('execute_command')",                          opts)
  bindings.map.normal("x",       "defx#async_action('execute_system')",                           opts)
  bindings.map.normal(";",       "defx#async_action('repeat')",                                   opts)

  bindings.map.normal("n",       "defx#async_action('new_file')",                                 opts)
  bindings.map.normal("N",       "defx#async_action('new_multiple_files')",                       opts)
  bindings.map.normal("m",       "defx#async_action('new_directory')",                            opts)

  bindings.map.normal("+",       "defx#async_action('resize', defx#get_context().winwidth + 10)", opts)
  bindings.map.normal("-",       "defx#async_action('resize', defx#get_context().winwidth - 10)", opts)
  bindings.map.normal("<C-r>",   "defx#async_action('redraw')",                                   opts)


  bindings.map.normal("[",       "<Plug>(defx-git-prev)",                                         git_opts)
  bindings.map.normal("]",       "<Plug>(defx-git-next)",                                         git_opts)

  bindings.map.normal("s",       "<Plug>(defx-git-stage)",                                        git_opts)
  bindings.map.normal("u",       "<Plug>(defx-git-reset)",                                        git_opts)
  bindings.map.normal("U",       "<Plug>(defx-git-discard)",                                      git_opts)

end
registry.auto("FileType", keymap, "defx")

local options = function ()
  local args = {
    "-buffer-name=文件",
    "-root-marker=[根]",
    "-listed",
    "-resume",
    "-toggle",
    "-sort=extension",
    "-columns=mark:indent:git:icons:filename:type",
    "-split=vertical",
    "-direction=topleft",
    "-winwidth=40"}

  bindings.map.normal("<Leader>i", ":Defx " .. table.concat(args, " ") .. "<Cr>")

end
registry.defer(options)

local theme = function ()
  bindings.let("defx_icons_enable_syntax_highlight", false)

  fn["defx#custom#column"]("git", "show_ignored", true)
end
registry.defer(theme)

