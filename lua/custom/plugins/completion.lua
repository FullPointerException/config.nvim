return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      -- Completion popup inline like the vscode
      "onsails/lspkind.nvim",
      -- Setup nvim-cmp as an lsp client
      "hrsh7th/cmp-nvim-lsp",
      -- Setup nvim-cmp as a file system path source
      "hrsh7th/cmp-path",
      -- Setup nvim-cmp as a source for buffer words
      "hrsh7th/cmp-buffer",
      -- Snippet engine
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        init = function()
          local ls = require("luasnip")
          local custom = require("custom.snippets.common.snippets_utils")
          ls.setup({
            -- Setup the ability for snippets to include base snippets, like "c" in "cpp"
            load_ft_func = custom.load_ft_func,
            ft_func = custom.ft_func
          })
        end
      },
      -- Setup LuaSnip as a completion engine for nvim-cmp
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require "custom.completion"
    end,
  },
}
