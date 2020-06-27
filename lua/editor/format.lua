local a = require "libs/async"
local bindings = require "libs/bindings"
local loop = require "libs/loop"
local registry = require "libs/registry"
local std = require "libs/std"


--#################### Format Region ####################

local misc = function ()

  -- join only add 1 space
  bindings.set("nojoinspaces")

end
registry.defer(misc)


local sort = function ()

  lv.sort_lines = function (selec)
    local r1, _, r2, _ = bindings.p_op_marks(selec)
    -- vim has mixed indexing
    r1, r2 = r1 - 1, r2 - 1 + 1
    local lines = api.nvim_buf_get_lines(0, r1, r2, true)
    table.sort(lines, function (a, b)
      return vim.stricmp(a, b) < 0
    end)
    api.nvim_buf_set_lines(0, r1, r2, true, lines)
  end

  bindings.map.normal("gu", "<cmd>set opfunc=v:lua.lv.sort_lines<CR>g@")
  bindings.map.visual("gu", "<Esc><cmd>lua lv.sort_lines()<CR>")

end
registry.defer(sort)


-- prettiers
local prettier = function ()

  local fmt_stream = function (prog, args)
    local lines = api.nvim_buf_get_lines(0, 0, -1, true)
    a.sync(function ()
      local args = {args = args, stream = table.concat(lines)}
      local code, new_lines, err = a.wait(loop.spawn(prog, args))
      if code ~= 0 then
        print(table.concat(err, ""))
      else
        a.wait(loop.main)
        api.nvim_buf_set_lines(0, 0, -1, true, new_lines)
      end
    end)()
  end

  local fmt_fs = function (prog, args)
    a.sync(function ()
      local filename = vim.fn.bufname("%")
      local args = {args = std.concat{args, {filename}}}
      local code, _, err = a.wait(loop.spawn(prog, args))
      if code ~= 0 then
        print(table.concat(err, ""))
      end
      a.wait(loop.main)
      bindings.exec[[checktime]]
    end)()
  end

  lv.formatters = {}

  lv.format = function ()
    local ft = vim.bo.filetype
    local formatter = lv.formatters[ft]
    local fmt = formatter.stdin and fmt_stream or fmt_fs
    fmt(formatter.prog, formatter.args)
  end

  -- remove default formatter
  bindings.map.normal("gq", "<cmd>lv.format()<CR>")
  bindings.map.normal("gQ", "<cmd>lv.format()<CR>")

end
registry.defer(prettier)
