--#################### ######### ####################
--#################### SD Region ####################
--#################### ######### ####################

local std = require "libs/std"
local loop = require "plugins/sd/libs/loop"
local a = require "plugins/sd/libs/async"

local m = math
local api = vim.api
local spawn = a.wrap(loop.spawn)
local dispatch = a.wrap(loop.dispatch)


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


local split_nul = function (str) 
  local acc, prev = {}, 1
  for i = 1,string.len(str) do
    local b = string.byte(str, i)
    if b == 0 then
      table.insert(acc, string.sub(str, prev, i - 1))
      prev = i + 1
    end
  end
  return acc
end


local search = function (pattern)
  local fd_args = fd_args or {"-H", "-L", "-0", "--type=f"} 
  table.insert(fd_args, pattern)

  return a.sync(function ()
    local opts = {args = fd_args}
    local ret = a.wait(spawn("fd", opts))
    assert(ret.code == 0, "fd / find :: non-zero exit")
    local files = split_nul(ret.out)
    return files 
  end)
end


local new_buf = function ()
  local buf = api.nvim_create_buf(false, true)
  assert(buf ~= 0, "failed to create buf")
  api.nvim_buf_set_option(buf, "bufhidden", "wipe") 
  api.nvim_buf_set_option(buf, "readonly", true)
  api.nvim_buf_set_option(buf, "modifiable", false)
  return buf
end


local new_listing_buf = function ()
  local buf = new_buf()
end


local new_detail_buf = function ()
  local buf = new_buf()
end


local calc_size = function (w, h)
  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")
  print(width, height)
  local ww = m.min(m.floor(width * w), width - 4)
  local hh = m.min(m.floor(height * h), height - 4)
  local ml, mt = (width - ww) / 2, (height - hh) / 2
  return {row=mt, col=ml, width=ww, height=hh}
end


local new_popup = function (buf, rel_w, rel_h)
  local size = calc_size(rel_w, rel_h)
  local opts = {relative = "editor",
                style = "minimal",}
  local win = api.nvim_open_win(buf, true, std.merge{opts, size})
  return win
end


local new_tab = function (sidebar_size)

end
