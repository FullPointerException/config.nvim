require "custom.snippets"

vim.opt.completeopt = {
  -- Popup completions in a menu
  "menu",
  -- Popup menu even if only one option
  "menuone",
  -- Do not select completion by default, force user to select
  "noselect",
}

-- Set the max number of completion items
vim.opt.pumheight = 20

-- Skip completion menu messages
vim.opt.shortmess:append "c"

local lspkind = require "lspkind"
lspkind.init {}

local cmp = require "cmp"

local per_source_max_item_count = 10
cmp.setup {
  sources = {
    { name = "nvim_lsp", max_item_count = per_source_max_item_count },
    { name = "luasnip", max_item_count = per_source_max_item_count },
    { name = "path", max_item_count = per_source_max_item_count },
    { name = "buffer", max_item_count = per_source_max_item_count },
    { name = "orgmode", max_item_count = per_source_max_item_count },
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
