--#################### ######### ####################
--#################### SD Region ####################
--#################### ######### ####################

local std = require "libs/std"
local loop = require "plugins/sd/libs/loop"
local async = require "plugins/sd/libs/async"

local m = math
local co = coroutine



local buf_info = function ()
  local curr_buf = api.nvim_get_current_buf()
  local bufs = api.nvim_call_function("getbufinfo", {})
 
  local info = std.map(bufs, function (buf)
    local handle = buf.bufnr
    local path = buf.name
    local modified = (function ()
      if buf.changed == 0 then
        return false
      else
        return true
      end
    end)()
    return {handle=handle, path=path, modified=modified}
  end)

  return {current = curr_buf, info = info}
end


local calc_size = function (w, h)
  local screens = api.nvim_list_uis()
  -- TODO: verify this
  local params = screens[1]
  local width, height = params.width, params.height
  local ww = m.min(m.floor(width * w), width - 4)
  local hh = m.min(m.floor(height * h), height - 4)
  local ml, mt = (width - ww) / 2, (height - hh) / 2
  return {row=mt, col=ml, width=ww, height=hh}
end


local show_win = function (rel_w, rel_h)
  local buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_option(buf, "bufhidden", "wipe") 
  assert(buf ~= 0)
  local size = calc_size(rel_w, rel_h)
  local opts = {relative = "editor",
                style = "minimal",}
  local win = api.nvim_open_win(buf, true, std.merge{opts, size})
  return {buf=buf, win=win}
end


