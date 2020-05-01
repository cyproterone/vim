--#################### ######### ####################
--#################### SD Region ####################
--#################### ######### ####################

local std = require "libs/std"
local loop = require "plugins/sd/libs/loop"
local a = require "plugins/sd/libs/async"

local m = math
local api = vim.api
local uv = vim.loop
local spawn = a.wrap(loop.spawn)
local dispatch = a.wrap(loop.dispatch)


local str_split = function (code, str)
  local len = string.len(str) + 1
  local acc, prev = {}, 1
  for i in std.range(1, len) do
    if i == len then
      if prev ~= i then
        table.insert(acc, string.sub(str, prev, i - 1))
      end
      break
    end
    local b = string.byte(str, i)
    if b == code then
      table.insert(acc, string.sub(str, prev, i - 1))
      prev = i + 1
    end
  end
  return acc
end


local str_trim = function (code, str)
  local len = string.len(str)
  local fst = nil
  for i in std.range(1, len) do
    if string.byte(str, i) ~= code then
      fst = string.sub(str, i, len)
      break
    end
  end
  local len = string.len(fst)
  local snd = nil 
  for i in std.range(len, 1, -1) do
    if string.byte(fst, i) ~= code then
      snd = string.sub(fst, 1, i)
      break
    end
  end
  return snd
end


local parse_fd = function (str) 
  local acc, prev = {}, 1
  for i in std.range(1, string.len(str)) do 
    local b = string.byte(str, i)
    if b == 0 then
      table.insert(acc, string.sub(str, prev, i - 1))
      prev = i + 1
    end
  end
  table.sort(acc, function (a, b)
    return vim.stricmp(a, b) < 0
  end)
  return acc
end


local search = function (pattern)
  local fd_args = fd_args or {"-H", "-L", "-0", "--type=f"} 
  table.insert(fd_args, pattern)
  local opts = {args = fd_args}

  return a.sync(function ()
    local ret = a.wait(spawn("fd", opts))
    assert(ret.code == 0, "fd / find :: non-zero exit")
    local files = parse_fd(ret.out)
    return files 
  end)
end


local sd = function (args)
  local flags = assert(args.flags)
  local pattern = assert(args.pattern)
  local replacement = assert(args.replacement)
  local file = assert(args.file)
  
  local sd_args = flags
  table.insert(sd_args, pattern)
  table.insert(sd_args, replacement)
  table.insert(sd_args, file)
  local opts = {args = sd_args}
  
  return a.sync(function ()
    local ret = a.wait(spawn("sd", opts))
    assert(ret.code == 0, "sd :: non-zero exit")
    return ret.out
  end)
end


local buf_info = function ()
  local curr_buf = api.nvim_get_current_buf()
  local bufs = api.nvim_call_function("getbufinfo", {})
 
  local info = {}
  for _, buf in ipairs(bufs) do
    local handle = buf.bufnr
    local path = buf.name
    local modified = (function ()
      if buf.changed == 0 then
        return false
      else
        return true
      end
    end)()
    info[handle] = {path = path, modified = modified}
  end

  return {current = curr_buf, bufs = info}
end


local buf_update = function (buf, lines)
  api.nvim_buf_set_option(buf, "modifiable", true)
  api.nvim_buf_set_lines(buf, 0, 0, true, lines)
  api.nvim_buf_set_option(buf, "modifiable", false)
end


local new_buf = function ()
  local buf = api.nvim_create_buf(false, true)
  assert(buf ~= 0, "failed to create buf")
  api.nvim_buf_set_option(buf, "bufhidden", "wipe") 
  api.nvim_buf_set_option(buf, "modifiable", false)
  return buf
end


local new_listing_buf = function ()
  local buf = new_buf()
  return buf
end


local new_detail_buf = function ()
  local buf = new_buf()
  return buf
end


local calibrate_win = function (win)
  api.nvim_win_set_option(win, "fillchars", "eob: ")
  api.nvim_win_set_option(win, "number", false)
  api.nvim_win_set_option(win, "relativenumber", false)
  api.nvim_win_set_option(win, "signcolumn", "no")
  api.nvim_win_set_option(win, "cursorcolumn", false)
  api.nvim_win_set_option(win, "foldcolumn", 0)
  api.nvim_win_set_option(win, "spell", false)
  api.nvim_win_set_option(win, "list", false)
end


local calc_size = function (w, h)
  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")
  local ww = m.min(m.floor(width * w), width - 4)
  local hh = m.min(m.floor(height * h), height - 4)
  local ml, mt = (width - ww) / 2, (height - hh) / 2
  return {row=mt, col=ml, width=ww, height=hh}
end


local new_popup = function (buf, rel_w, rel_h)
  local size = calc_size(rel_w, rel_h)
  local opts = {relative = "editor"}
  local win = api.nvim_open_win(buf, true, std.merge{opts, size})
  calibrate_win(win)
end


local order_wins = function (wins)
  local wins = std.map(wins, std.id)
  table.sort(wins, function (a, b)
    local _, col_a = unpack(api.nvim_win_get_position(a))
    local _, col_b = unpack(api.nvim_win_get_position(b))
    return col_a < col_b
  end)
  return wins
end


local new_tab = function (sidebar, main, rel_size)
  api.nvim_command[[tabnew]]
  local tab = api.nvim_get_current_tabpage()
  api.nvim_command[[vsplit]]
  local wins = api.nvim_tabpage_list_wins(tab)
  local win_s, win_m = unpack(order_wins(wins))
  api.nvim_win_set_buf(win_s, sidebar)
  api.nvim_win_set_buf(win_m, main)
  local width = api.nvim_get_option("columns")
  api.nvim_win_set_width(win_s, m.ceil(width * rel_size))
  std.foreach(wins, calibrate_win)
end


