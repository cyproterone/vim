--#################### ######### ####################
--#################### SD Region ####################
--#################### ######### ####################

local std = require "libs/std"
local s = require "libs/string"
local loop = require "plugins/sd/libs/loop"
local a = require "plugins/sd/libs/async"

local m = math
local api = vim.api
local uv = vim.loop
local spawn = a.wrap(loop.spawn)
local dispatch = a.wrap(loop.dispatch)



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
  
  local sd_args = flags
  table.insert(sd_args, pattern)
  table.insert(sd_args, replacement)
  local opts = {args = sd_args}

  if args.file then
    table.insert(sd_args, args.file)
  else
    opts["stream"] = assert(args.content)
  end
  
  return a.sync(function ()
    local ret = a.wait(spawn("sd", opts))
    assert(ret.code == 0, "sd :: non-zero exit")
    return ret.out
  end)
end


local write_tmp = function (content)
  local mode = 555
  return a.sync(function ()
    local ret = a.wait(spawn("mktemp", {}))
    local path = s.trim(string.byte("\n"), ret.out)
    local err, fd = a.wait(a.wrap(uv.fs_open)(path, "w+", mode))
    assert(not err, err)
    local err = a.wait(a.wrap(uv.fs_write)(fd, content, 0))
    assert(not err, err)
    local err = a.wait(a.wrap(uv.fs_close)(fd))
    assert(not err, err)
    return path
  end)
end


local diff = function (before, after)
  local args = {"--suppress-common-lines",
                "--width=999",
                "-"}
  local opts = {args = args, stream = after}

  local seek = a.sync(function ()
    if before.path then
      return before.path
    else
      local content = assert(before.content)
      local path = write_tmp(content)
      return path
    end
  end)

  return a.sync(function ()
    local path = a.wait(seek)
    table.insert(opts.args, path)
    local ret = a.wait(spawn("diff", opts))
    assert(ret.code ~= 2, "diff :: error exit")
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
  api.nvim_buf_set_option(buf, "filetype", "diff")
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


local order_wins = function (wins)
  local wins = std.map(wins, std.id)
  table.sort(wins, function (a, b)
    local _, col_a = unpack(api.nvim_win_get_position(a))
    local _, col_b = unpack(api.nvim_win_get_position(b))
    return col_a < col_b
  end)
  return wins
end


local new_tab = function (main, sidebar, rel_size)
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


-- required due to textlock
local main_loop = function (f)
  vim.schedule(f)
end


