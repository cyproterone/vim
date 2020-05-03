--#################### ############### ####################
--#################### Buffers Region ####################
--#################### ############### ####################

local s = require "libs/string"
local api = vim.api
local c = require "plugins/sd/consts"


local is_modified = function (buf)
    local val = api.nvim_buf_get_option(buf, "modified")
    if val == "nomodified" then
      return true
    else
      return false
    end
end


local new = function (lines)
  local buf = api.nvim_create_buf(false, true)
  assert(buf ~= 0, "failed to create buf")
  api.nvim_buf_set_lines(buf, 0, 0, true, lines)
  api.nvim_buf_set_option(buf, "readonly", true)
  api.nvim_buf_set_option(buf, "modifiable", false)
  api.nvim_buf_set_option(buf, "bufhidden", "wipe") 
  return buf
end


local new_listing = function (files)
  local buf = new(files)
  api.nvim_buf_set_option(buf, "filetype", c.ft_listing)
  return buf
end


local new_input = function ()
  local buf = new({})
  api.nvim_buf_set_option(buf, "filetype", c.ft_input)
  return buf
end


local new_detail = function (diff)
  local lines = s.split(string.byte("\n"), diff)
  local buf = new(lines)
  api.nvim_buf_set_option(buf, "filetype", "diff")
  return buf
end


return {
  list = list,
  new_input = new_input,
  new_listing = new_listing,
  new_detail = new_detail,
}
