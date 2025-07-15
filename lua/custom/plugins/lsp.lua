return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Neovim lua lsp
    "folke/neodev.nvim",

    -- Manage external editor tooling such as LSP Servers, linters, etc.
    "williamboman/mason.nvim",
    -- Glue mason.nvim and nvim-lspconfig together
    "williamboman/mason-lspconfig.nvim",
    -- Uses mason to keep tools up to date
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- An overlay for notifactations and LSP progress messages
    { "j-hui/fidget.nvim", opts = {} },

    -- Autoformatter
    "stevearc/conform.nvim",
  },
  config = function()
    require("neodev").setup {
    }

    local capabilities = nil
    if pcall(require, "cmp_nvim_lsp") then
      capabilities = require("cmp_nvim_lsp").default_capabilities()
    end

    local lspconfig = require "lspconfig"

    local servers = {
      -- Go
      -- If trouble installing gopls, check that go is the most recent version
      gopls = {
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      },
      -- Zig
      zls = {
      },
      -- Lua
      lua_ls = {
        server_capabilities = {
          semanticTokensProvider = vim.NIL,
        },
      },
      -- Clangd (C/C++)
      clangd = {
        init_options = { clangdFileStatus = true },
        filetypes = { "c", "cpp" },
      },
      -- CMake
      cmake = {
        filetypes = { 'cmake' },
      },
      -- qmlls
      qmlls = {
        enabled = false,
        cmd = { "qmlls", "-b", "build/qml_modules" },
        manual_install = true,
        filetypes = { "qml", "qmljs" },
      },
      -- Bash
      -- If trouble installing bashls, make sure npm is installed
      bashls = {
        cmd = { 'bash-language-server', 'start' },
      },
      -- Odin
      ols = {
      },
      -- Protobuf
      protols = {
        filetypes = { 'proto' },
        root_markers = { '.git' },
      },
    }

    local servers_to_install = vim.tbl_filter(function(key)
      local t = servers[key]
      if type(t) == "table" then
        return not t.manual_install
      else
        return t
      end
    end, vim.tbl_keys(servers))

    require("mason").setup()
    local ensure_installed = {
    }

    vim.list_extend(ensure_installed, servers_to_install)
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    for name,config in pairs(servers) do
      if config == true then
        config = {}
      end
      config = vim.tbl_deep_extend("force", {}, {
        capabilities = capabilities,
      }, config)

      lspconfig[name].setup(config)
    end

    local disable_semantic_tokens = {
      lua = true,
    }

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "Unable to get_client_by_id for LSP")

        local settings = servers[client.name]
        if type(settings) ~= "table" then
          settings = {}
        end

        local builtin = require "telescope.builtin"
        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0, desc = "LSP definitions", })
        vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0, desc = "LSP references", })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "LSP declaration", })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0, desc = "LSP type definition", })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "LSP buffer hover", })
        vim.keymap.set("n", "<space>hd", vim.diagnostic.open_float, { buffer = 0, desc = "LSP View Diagnostic" })
        vim.keymap.set("n", "<space>hca", vim.lsp.buf.code_action, { buffer = 0, desc = "LSP View Code Action" })

        -- Refactorings
        vim.keymap.set("n", "<space>rr", vim.lsp.buf.rename, { buffer = 0, desc = "LSP rename", })

        local filetype = vim.bo[bufnr].filetype
        if disable_semantic_tokens[filetype] then
          client.server_capabilities.semanticTokensProvider = nil
        end

        -- Override server capabilities
        if settings.server_capabilities then
          for k, v in pairs(settings.server_capabilities) do
            if v == vim.NIL then
              ---@diagnostic disable-next-line: cast-local-type
              v = nil
            end

            client.server_capabilities[k] = v
          end
        end
      end,
    })
  end,
}
