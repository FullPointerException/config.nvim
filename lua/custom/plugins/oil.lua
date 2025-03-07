return {
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      CustomOilBar = function()
        local path = vim.fn.expand "%"
        path = path:gsub("oil://", "")

        return "  " .. vim.fn.fnamemodify(path, ":.")
      end

      require("oil").setup {
        columns = {
          "icon",
          --"permissions",
          --"size",
          --"mtime",
        },
        win_options = {
          winbar = "%{v:lua.CustomOilBar()}",
        },
        view_options = {
          show_hidden = true,
        },
      }

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open containing directory" })
      vim.keymap.set("n", "<space>-", require("oil").toggle_float, { desc = "Open containing directory in floating popup" })
    end,
  }
}

