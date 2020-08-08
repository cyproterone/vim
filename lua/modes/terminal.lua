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
      pcall(api.nvim_win_close, linked, true)
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


  local buf_mark = "terminal_buffer"
  local term_buf = function ()
    local bufs = api.nvim_list_bufs()
    for _, buf in ipairs(bufs) do
      local go, mark = pcall(api.nvim_buf_get_var, buf, buf_mark)
      if go and mark then
        return buf, true
      end
    end
    local buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_var(buf, buf_mark, true)
    return buf, false
  end


  local open_float_win = function (buf, width, height, row, col, focusable)
    local conf = {relative  = "editor",
                  anchor    = "NW",
                  width     = width,
                  height    = height,
                  row       = row,
                  col       = col,
                  focusable = focusable,
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
    local border_win = open_float_win(border, width, height, row, col, false)
    local buf, reuse = term_buf()
    local win = open_float_win(buf, width - 2, height - 2, row + 1, col + 1, true)
    linked_windows[win] = border_win
    return win, buf, reuse
  end


  local job_win_assoc = {}
  lv.term_notify = function (job_id, code, _)
    local win = job_win_assoc[job_id]
    if win and code == 0 then
      pcall(api.nvim_win_close, win, true)
    end
    job_win_assoc[job_id] = nil
  end


  bindings.exec[[function! Lv_term_notify (job_id, code, event_type)
    call v:lua.lv.term_notify(a:job_id, a:code, a:event_type)
  endfunction]]

  local open = function (prog)
    local win, buf, reuse = open_float_win_bordered()
    if win == 0 then
      api.nvim_err_writeln("Invaild window")
    else
      if not reuse then
        local program = prog or {env["SHELL"]}
        local job_id = fn.termopen(program, {on_exit = "Lv_term_notify"})
        job_win_assoc[job_id] = win
      end
      bindings.exec[[startinsert]]
    end
  end

  lv.toggle_float_term = function (prog)
    local windows = api.nvim_list_wins()
    for _, win in ipairs(windows) do
      local buf = api.nvim_win_get_buf(win)
      local go, mark = pcall(api.nvim_buf_get_var, buf, buf_mark)
      if go and mark then
        pcall(api.nvim_win_close, win, true)
        return
      end
    end
    open(prog)
  end


  -- hotkeys
  bindings.map.normal("<leader>u", "<cmd>lua lv.toggle_float_term()<cr>")

end
registry.defer(float_term)
