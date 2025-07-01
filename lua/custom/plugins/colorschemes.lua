
-- Falses italics in hlMap.italic, hlMap.cterm.italic, and hlMap.gui.italics
-- Only does this for fields that already exist
local function remove_hl_italics_from_table(hlMap)
  if(hlMap.italic ~= nil) then
    hlMap.italic = false
  end

  if(hlMap.cterm ~= nil) then
      if(hlMap.cterm.italic ~= nil) then
        hlMap.cterm.italic = false
      end
  end

  if(hlMap.gui ~= nil) then
      if(hlMap.gui.italic ~= nil) then
        hlMap.gui.italic = false
      end
  end

  return hlMap
end

-- Loads groupName, removes the italics from it, and resets it
local function no_italics(groupName)
  local hlTable = vim.api.nvim_get_hl(0, { name = groupName})
  hlTable = remove_hl_italics_from_table(hlTable)
  vim.api.nvim_set_hl(0, groupName, hlTable)

end

local function add_italics(groupName)
  local hlTable = vim.api.nvim_get_hl(0, { name = groupName})
  hlTable.italic = true
  vim.api.nvim_set_hl(0, groupName, hlTable)
end

local function set_fg(groupName, color)
  local hlTable = vim.api.nvim_get_hl(0, { name = groupName })
  hlTable.fg = color
  vim.api.nvim_set_hl(0, groupName, hlTable)
end

return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
      --no_italics("Comment")
      --no_italics("Conditional")
      --no_italics("ErrorMsg")
      add_italics("Boolean")

      no_italics("DiagnosticError")
      no_italics("DiagnosticWarn")
      no_italics("DiagnosticInfo")
      no_italics("DiagnosticHint")
      no_italics("DiagnosticOk")

      no_italics("DiagnosticVirtualTextError")
      no_italics("DiagnosticVirtualTextWarn")
      no_italics("DiagnosticVirtualTextInfo")
      no_italics("DiagnosticVirtualTextHint")
      no_italics("DiagnosticVirtualTextOk")

      set_fg("Comment", 0x9090A7) -- 7106694

      set_fg("LineNr", 0xA0A0A0)
    end,
  },
  -- Not using, but here as a fallback
  -- "rose-pine/neovim",
}

