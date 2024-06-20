local M = {}

local builtin = require "el.builtin"
local extensions = require "el.extensions"
local subscribe = require "el.subscribe"
local sections = require "el.sections"

vim.opt.laststatus = 3 -- Only 1, but always show

M.setup = function()
  require("el").setup {
    generator = function()
      local segments = {}

      -- Add [Normal], [Insert], etc
      table.insert(segments, extensions.mode)
      table.insert(segments, " ")

      -- Add git branch name
      table.insert(
        segments,
        subscribe.buf_autocmd("el-git-branch", "BufEnter", function(win, buf)
          local branch = extensions.git_branch(win, buf)
          if branch then
            return branch
          end
        end)
      )
      -- Add git changes (if any)
      table.insert(
        segments,
        subscribe.buf_autocmd("el-git-changes", "BufWritePost", function(win, buf)
          local changes = extensions.git_changes(win, buf)
          if changes then
            return changes
          end
        end)
      )

      table.insert(segments, sections.split)
      -- Add current file name
      table.insert(segments, "%f")

      table.insert(segments, sections.split)
      -- Add filetype
      table.insert(segments, builtin.filetype)
      -- Add [line:col]
      table.insert(segments, "[")
      table.insert(segments, builtin.line_with_width(3))
      table.insert(segments, ":")
      table.insert(segments, builtin.column_with_width(2))
      table.insert(segments, "]")
      -- Add percentage
      table.insert(segments, "[")
      table.insert(segments, builtin.percentage_through_window)
      table.insert(segments, "]")


      return segments
    end,
  }
end

M.setup()

return M
