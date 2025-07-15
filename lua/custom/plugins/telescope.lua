return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      -- Reuseable lua functions
      "nvim-lua/plenary.nvim",
      -- FZF
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = 'cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      },
      -- Allows neovim core things to use the telescope picker
      "nvim-telescope/telescope-ui-select.nvim",
      -- Makes history based on input + picker + cwd
      "nvim-telescope/telescope-smart-history.nvim",
      -- SQLite
      "kkharji/sqlite.lua",
    },
    config = function()
      require "custom.telescope"
    end,
  },

}

