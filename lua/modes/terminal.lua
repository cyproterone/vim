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

  local open_float_win = function ()
    local t_width, t_height = vim.o.columns, vim.o.lines
    local width  = math.floor((t_width - margin) * rel_size)
    local height = math.floor((t_height - margin) * rel_size)
    local row, col = (t_height - height) / 2, (t_width - width) / 2
    local conf = {relative  = "editor",
                  anchor    = "NW",
                  width     = width,
                  height    = height,
                  row       = row,
                  col       = col,
                  focusable = false,
                  style     = "minimal"}
    local buf = api.nvim_create_buf(false, true)
    local win = api.nvim_open_win(buf, true, conf)
    if win ~= 0 then
      api.nvim_win_set_option(win, "winhighlight", "")
    end
    return win
  end

  lv.term_notify = function (job_id, code, event_type)
    print(job_id, code, event_type)
  end


  bindings.exec[[function! Lv_term_notify (job_id, code, event_type)
    lua lv.term_notify(job_id, code, event_type)
  endfunction]]

  lv.toggle_float_term = function (prog)
    local win = open_float_win()
    if win == 0 then
      api.nvim_err_writeln("Invaild window")
    else
      local program = prog or {env["SHELL"]}
      local job = fn.termopen(program, {on_exit = "Lv_term_notify"})
    end
  end

  -- hotkeys
  bindings.map.normal("<leader>u", "<cmd>lua lv.toggle_float_term()<cr>")

end
registry.defer(float_term)
