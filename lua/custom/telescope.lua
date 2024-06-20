local data = assert(vim.fn.stdpath "data")

require("telescope").setup {
  defaults = {
    history = {
      -- Needed for smart_history extension
      path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
      limit = 100,
    }
  },
  extensions = {
    fzf,
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
}

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require "telescope.builtin"

-- Find things
vim.keymap.set("n", "<space>fd", builtin.find_files)
vim.keymap.set("n", "<space>ft", builtin.git_files)
vim.keymap.set("n", "<space>fh", builtin.help_tags)
vim.keymap.set("n", "<space>fg", builtin.live_grep)

-- Current buffer search, no telescope ui
vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)

-- Grep the current word under the cursor
vim.keymap.set("n", "<space>gw", builtin.grep_string)

-- Find files in neovim config
vim.keymap.set("n", "<space>en", function()
  builtin.find_files { cwd = vim.fn.stdpath "config" }
end)

