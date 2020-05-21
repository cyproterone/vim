local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### File Manager Region ####################

-- needs :UpdateRemotePlugins
registry.install("Shougo/defx.nvim")
registry.install("kristijanhusak/defx-icons")
registry.install("kristijanhusak/defx-git")

local options = function ()
  fn["defx#custom#option"]("_", {
    buffer_name = "文件",
    root_marker = "[根]",
    listed = true,
    resume = true,
    columns = "mark:indent:git:icons:filename:type",
    ignored_files = ".^",
    split = "vertical",
    direction = "topleft",
    winwidth = 40})
end
registry.defer(options)


local keymap = function (buf)
  local opts     = {expr = true,     buffer = buf}
  local git_opts = {noremap = false, buffer = buf}
  local map      = bindings.map.normal

  map("q",         "defx#async_action('quit')",                                     opts)

  map("<Tab>",     "defx#async_action('open_tree', 'toggle')",                      opts)
  map("`",         "defx#async_action('open_tree', ['toggle', 'recursive'])",       opts)
  map("<Enter>",   "defx#async_action('drop')",                                     opts)
  map("<Up>",      "line('.') == 1 ? 'G' : '<Up>'",                                 opts)
  map("<Down>",    "line('.') == line('$') ? 'gg' : '<Down>'",                      opts)
  map("<Left>",    "line('.') == 1 ? 'G' : '<Up>'",                                 opts)
  map("<Right>",   "line('.') == line('$') ? 'gg' : '<Down>'",                      opts)
  map("<M-Left>",  "defx#async_action('cd', ['..'])",                               opts)
  map("<M-Right>", "defx#async_action('drop')",                                     opts)
  map("~",         "defx#async_action('cd', [getcwd()])",                           opts)
  map("cd",        "defx#async_action('change_vim_cwd')",                           opts)
  map(".",         "defx#async_action('toggle_ignored_files')",                     opts)

  map("<Space>",   "defx#async_action('toggle_select')",                            opts)
  map("*",         "defx#async_action('toggle_select_all')",                        opts)
  map("w",         "defx#async_action('clear_select_all')",                         opts)
  map("y",         "defx#async_action('copy')",                                     opts)
  map("yy",        "defx#async_action('yank_path')",                                opts)
  map("p",         "defx#async_action('paste')",                                    opts)
  map("r",         "defx#async_action('rename')",                                   opts)
  map("m",         "defx#async_action('move')",                                     opts)
  map("d",         "defx#async_action('remove')",                                   opts)
  map("t",         "defx#async_action('remove_trash')",                             opts)
  map("!",         "defx#async_action('execute_command')",                          opts)
  map("o",         "defx#async_action('execute_system')",                           opts)
  map(";",         "defx#async_action('repeat')",                                   opts)

  map("n",         "defx#async_action('new_file')",                                 opts)
  map("N",         "defx#async_action('new_directory')",                            opts)

  map(">",         "defx#async_action('resize', defx#get_context().winwidth + 10)", opts)
  map("<",         "defx#async_action('resize', defx#get_context().winwidth - 10)", opts)
  map("<C-r>",     "defx#async_action('redraw')",                                   opts)


  map("[",         "<Plug>(defx-git-prev)",                                         git_opts)
  map("]",         "<Plug>(defx-git-next)",                                         git_opts)

  map("s",         "<Plug>(defx-git-stage)",                                        git_opts)
  map("u",         "<Plug>(defx-git-reset)",                                        git_opts)
  map("U",         "<Plug>(defx-git-discard)",                                      git_opts)

end
registry.auto("FileType", keymap, "defx")


local key = function ()
  bindings.map.normal("<Leader>i", ":Defx -toggle<CR>")
end
registry.defer(key)


local theme = function ()
  bindings.let("defx_icons_enable_syntax_highlight", false)

  -- neat idea, doesn't work
  fn["defx#custom#column"]("git", "show_ignored", false)
end
registry.defer(theme)
