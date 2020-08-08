local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Terminal Region ####################

-- hotkeys
local hotkeys = function ()

  -- leave terminal
  bindings.map.terminal("<c-g>", [[<c-\><c-n>]])

end
registry.defer(hotkeys)


-- floating terminal
local float_term = function ()

  local rel_size = 0.95
  local margin = 2


  local linked_windows = {}
  local win_close_cmd = function ()
    local win = tonumber(fn.expand("<afile>"))
    local linked = linked_windows[win]
    if linked then
      api.nvim_win_close(linked, true)
    end
  end
  registry.auto("WinClosed", win_close_cmd)


  local border_buf = function (width, height)
    local buf = api.nvim_create_buf(false, true)
    local lines = {}

    local top = "╭" .. string.rep("─", width - 2) .. "╮"
    local mid = "│" .. string.rep(" ", width - 2) .. "│"
    local btm = "╰" .. string.rep("─", width - 2) .. "╯"

    table.insert(lines, top)
    for _ = 1, (height - 2) do
      table.insert(lines, mid)
    end
    table.insert(lines, btm)

    api.nvim_buf_set_lines(buf, 0, -1, true, lines)
    return buf
  end


  local open_float_win = function (buf, width, height, row, col)
    local conf = {relative  = "editor",
                  anchor    = "NW",
                  width     = width,
                  height    = height,
                  row       = row,
                  col       = col,
                  focusable = false,
                  style     = "minimal"}
    local win = api.nvim_open_win(buf, true, conf)
    if win ~= 0 then
      api.nvim_win_set_option(win, "winhighlight", "Normal:Floating")
    end
    return win
  end


  local open_float_win_bordered = function ()
    local t_width, t_height = vim.o.columns, vim.o.lines
    local width  = math.floor((t_width - margin) * rel_size)
    local height = math.floor((t_height - margin) * rel_size)
    local row, col = (t_height - height) / 2, (t_width - width) / 2
    local border = border_buf(width, height)
    local border_win = open_float_win(border, width, height, row, col)
    local buf = api.nvim_create_buf(false, true)
    local win = open_float_win(buf, width - 2, height - 2, row + 1, col + 1)
    linked_windows[win] = border_win
    return win
  end


  lv.term_notify = function (job_id, code, event_type)
    print(job_id, code, event_type)
  end


  bindings.exec[[function! Lv_term_notify (job_id, code, event_type)
    call v:lua.lv.term_notify(a:job_id, a:code, a:event_type)
  endfunction]]


  lv.toggle_float_term = function (prog)
    local win = open_float_win_bordered()
    if win == 0 then
      api.nvim_err_writeln("Invaild window")
    else
      local program = prog or {env["SHELL"]}
      local job = fn.termopen(program, {on_exit = "Lv_term_notify"})
      bindings.exec[[startinsert]]
    end
  end


  -- hotkeys
  bindings.map.normal("<leader>u", "<cmd>lua lv.toggle_float_term()<cr>")

end
registry.defer(float_term)
