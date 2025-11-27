local M = {}

function M.setup()
  local signs = {
    Error = "✗",
    Warning = "",
    Warn = "",
    Info = "!",
    Hint = "✦",
  }
  local icons = {
    [vim.diagnostic.severity.ERROR] = "✗ ",
    [vim.diagnostic.severity.WARN]  = " ",
  }

  -- Configuração dos diagnostics
  vim.diagnostic.config({
    virtual_text = {
      spacing = 1,
      severity = { min = vim.diagnostic.severity.WARN },
      format = function(d)
        local icon = icons[d.severity] or ""
        return icon .. d.message:gsub("\n", " ")
      end,
    },
  })

  -- Signs na lateral
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
      text = icon,
      texthl = hl,
      numhl = hl,
    })
  end
end

return M
