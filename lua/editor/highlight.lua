require "libs/set"


highlight = function ()

  local plugins = {}
  local defer = {}

  --#################### Highlight Region ####################

  -- syntax highlight
  local syntax_highlight = function ()
    api.nvim_command(bindings.arbitrary("filetype plugin indent on"))
    api.nvim_command(bindings.arbitrary("syntax on"))
  end
  table.insert(defer, syntax_highlight)


  -- show line count
  local line_number = function ()
    api.nvim_command(bindings.set.id("number"))
  end
  table.insert(defer, line_number)


  return {
    plugins = plugins,
    defer = defer,
  }
end
