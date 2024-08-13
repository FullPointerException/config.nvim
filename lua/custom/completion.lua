require "custom.snippets"

vim.opt.completeopt = {
  -- Popup completions in a menu
  "menu",
  -- Popup menu even if only one option
  "menuone",
  -- Do not select completion by default, force user to select
  "noselect",
}

-- Skip completion menu messages
vim.opt.shortmess:append "c"

local lspkind = require "lspkind"
lspkind.init {}

local cmp = require "cmp"

cmp.setup {
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
    { name = "orgmode" },
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
  },
  -- Set LuaSnip to handle the nvim-cmp snippet expansion
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
}
