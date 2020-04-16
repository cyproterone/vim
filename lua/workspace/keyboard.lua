require "libs/set"


keyboard = function ()

  local plugins = {}
  local defer = {}


  --#################### Keyboard Region ####################

  -- enable smartcase
  local smartcase = function ()
    vim.api.nvim_command(bindings.set.id("ignorecase"))
    vim.api.nvim_command(bindings.set.id("smartcase"))
  end
  table.insert(defer, smartcase)


  local normalize_keystrokes = function ()
    -- allow nav keys to wrap around
    vim.api.nvim_command(bindings.set.plus("whichwrap", "h,l,<,>"))
    -- normalize backspace in insertion mode
    vim.api.nvim_command(bindings.set.eq("backspace", "indent,eol,start"))
  end
  table.insert(defer, normalize_keystrokes)


  return {
    plugins = plugins,
    defer = defer,
  }
end
