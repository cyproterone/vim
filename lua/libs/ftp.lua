--#################### ########## ####################
--#################### FTP Region ####################
--#################### ########## ####################
local registry = require "libs/registry"
local set = require "libs/set"


local _ftp = set.new()
local _shebang = {}


local shebang = function (ft, lines)
  for _, line in ipairs(lines) do
    local escaped = [[\V\^]] .. fn.escape(line, [[\]])
    _shebang[escaped] = ft
  end
end


local lsp_root = function ()
  return function (file_name)
    return fn.getcwd()
  end
end


local defer = function (ft, ftplugin)
  set.add(_ftp, ftplugin)
  local ftp = function (kill)
    if not set.contains(_ftp, ftplugin) then
      return
    end
    set.subtract(_ftp, ftplugin)
    ftplugin()
    kill()
    api.nvim_out_write("-- LSP 加载: " .. table.concat(ft, ",") .. " --\n")
  end
  registry.auto("FileType", ftp, ft)
end


local always = function (ft, ftplugin)
  local ftp = function ()
    local buf = tonumber(fn.expand("<abuf>"))
    ftplugin(buf)
  end
  registry.auto("FileType", ftp, ft)
end


local materialize = function ()

  local shebang = function ()
    local buf = tonumber(fn.expand("<abuf>"))
    local line = unpack(api.nvim_buf_get_lines(buf, 0, 1, true))
    for sb, ft in pairs(_shebang) do
      if fn.match(line, sb) ~= -1 then
        api.nvim_buf_set_option(buf, "filetype", ft)
        break
      end
    end
  end

  registry.auto("BufRead", shebang)
end


return {
  shebang = shebang,
  lsp_root = lsp_root,
  defer = defer,
  always = always,
  materialize = materialize,
}
