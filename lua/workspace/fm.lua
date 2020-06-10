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


-- auto update
local update = function ()

  local check = function ()
    vim.fn["defx#call_async_action"]("redraw")
  end
  registry.auto("FocusGained", check, "*", "silent")

  local auto_check = function ()
    registry.auto("BufEnter", check, "<buffer>", "silent")
  end
  registry.auto("FileType", auto_check, "defx")

end
registry.defer(update)


local keymap = function (buf)
  local opts = {expr = true, buffer = buf}
  local git_opts = {noremap = false, buffer = buf}

  local map = function (opts)
    return function (lhs, rhs)
      bindings.map.normal(lhs, rhs ,opts)
    end
  end

  local m1 = map(opts)
  local m2 = map(git_opts)

  m1("q",             "defx#async_action('quit')")

  m1("<Tab>",         "defx#is_directory() ? defx#async_action('open_tree', 'toggle') : defx#async_action('drop') . ':Defx <CR>'")
  m1("<2-LeftMouse>", "defx#is_directory() ? defx#async_action('open_tree', 'toggle') : defx#async_action('drop') . ':Defx <CR>'")
  m1("`",             "defx#async_action('open_tree', ['toggle', 'recursive'])")
  m1("<Enter>",       "defx#async_action('drop')")
  m1("<M-Up>",        "defx#async_action('cd', ['..'])")
  m1("<M-Down>",      "defx#async_action('drop')")
  m1("<M-Left>",      "defx#async_action('cd', ['..'])")
  m1("<M-Right>",     "defx#async_action('drop')")
  m1("~",             "defx#async_action('cd', [getcwd()])")
  m1("cd",            "defx#async_action('change_vim_cwd')")
  m1(".",             "defx#async_action('toggle_ignored_files')")

  m1("<Space>",       "defx#async_action('toggle_select')")
  m1("*",             "defx#async_action('toggle_select_all')")
  m1("w",             "defx#async_action('clear_select_all')")
  m1("y",             "defx#async_action('copy')")
  m1("yy",            "defx#async_action('yank_path')")
  m1("p",             "defx#async_action('paste')")
  m1("r",             "defx#async_action('rename')")
  m1("x",             "defx#async_action('move')")
  m1("d",             "defx#async_action('remove')")
  m1("t",             "defx#async_action('remove_trash')")
  m1("!",             "defx#async_action('execute_command')")
  m1("o",             "defx#async_action('execute_system')")
  m1(";",             "defx#async_action('repeat')")
  m1("a",             "defx#async_action('new_file')")


  m1(">",             "defx#async_action('resize', defx#get_context().winwidth + 10)")
  m1("<",             "defx#async_action('resize', defx#get_context().winwidth - 10)")
  m1("<C-r>",         "defx#async_action('redraw')")


  m2("[",             "<Plug>(defx-git-prev)")
  m2("]",             "<Plug>(defx-git-next)")

  m2("s",             "<Plug>(defx-git-stage)")
  m2("u",             "<Plug>(defx-git-reset)")
  m2("U",             "<Plug>(defx-git-discard)")

end
registry.auto("FileType", keymap, "defx")


local key = function ()
  bindings.map.normal("<Leader>i", "<cmd>Defx -toggle<CR>")
end
registry.defer(key)


local theme = function ()
  vim.g.defx_icons_enable_syntax_highlight = false

  -- neat idea, doesn't work
  fn["defx#custom#column"]("git", "show_ignored", false)
end
registry.defer(theme)

