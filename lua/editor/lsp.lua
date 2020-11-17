local a = require "libs/async"
local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### LSP Region ####################

registry.install("neovim/nvim-lspconfig")
local lsp_keybinds = function ()

  bindings.exec[[lua lv.lsp = require "lspconfig"]]

  bindings.set("omnifunc", "v:lua.vim.lsp.omnifunc")

  bindings.map.normal("H", "<cmd>lua vim.lsp.util.show_line_diagnostics()<cr>")
  bindings.map.normal("K", "<cmd>lua vim.lsp.buf.hover()<cr>")
  bindings.map.normal("L", "<cmd>lua vim.lsp.buf.code_action()<cr>")

  bindings.map.normal("gp", "<cmd>lua vim.lsp.buf.definition()<cr>")
  bindings.map.normal("gP", "<cmd>lua vim.lsp.buf.references()<cr>")

  bindings.map.normal("gl", "<cmd>lua vim.lsp.buf.declaration()<cr>")
  bindings.map.normal("gL", "<cmd>lua vim.lsp.buf.implementation()<cr>")

  bindings.map.normal("go", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
  bindings.map.normal("gO", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

  bindings.map.normal("ge", "<cmd>lua vim.lsp.buf.document_symbol()<cr>")
  bindings.map.normal("gE", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>")

end
registry.defer(lsp_keybinds)


local lsp_selection = function ()
  return a.sync(function ()
      local s_range = a.wait(function (cb)
        local params = vim.lsp.util.make_position_params()
        local ans = function (err, _, ret)
          if err then
            cb(nil)
          else
            cb(ret and ret.range)
          end
        end
        vim.lsp.buf_request(0, "textDocument/selectionRange", params, ans)
      end)

      if not s_range then
        return nil
      else
        local b_row, b_col = s_range.start.line, s_range.start.character
        local e_row, e_col = s_range["end"].line, s_range["end"].character
        local rows = api.nvim_buf_get_lines(0, b_row, e_row + 1, true)
        if b_row == e_row then
          return string.sub(rows[1], b_col + 1, e_col + 1)
        else
          return inl
        end
      end
  end)
end


local lsp_rename = function ()

  lv.lsp_rename = function ()
    a.sync(function ()
      local selected = a.wait(lsp_selection())

      local selection = selected or fn.expand("<cword>")
      local new_name = fn.input("New name: ", selection)
      if not new_name or #new_name == 0 then
        return
      end

      vim.lsp.buf.rename(new_name)
    end)()
  end

  bindings.map.normal("R", "<cmd>lua lv.lsp_rename()<cr>")

end
registry.defer(lsp_rename)
