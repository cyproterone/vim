--#################### ######### ####################
--#################### SD Region ####################
--#################### ######### ####################

local std = require "libs/std"

local replace = function ()
  local buffers = api.nvim_list_bufs()
  local curr_buf = api.nvim_get_current_buf()

  for _, buf in ipairs(buffers) do
    print(buf)
  end

end


local calc_size = function (w, h)
  local screens = api.nvim_list_uis()
  -- TODO: verify this
  local params = screens[1]
  local width, height = params.width, params.height
  local ww, hh = math.floor(width * w), math.floor(height * h)
  local ml, mt = (width - ww) / 2, (height - hh) / 2
  return {row=mt, col=ml, width=ww, height=hh}
end


local float_win = function (rel_w, rel_h)
  local buf = api.nvim_create_buf(false, true)
  assert(buf ~= 0)
  local size = calc_size(rel_w,rel_h)
  local opts = {relative = "editor",
                style = "minimal",}
  local win = api.nvim_open_win(buf, true, std.merge{opts, size})
end


replace()
float_win()
