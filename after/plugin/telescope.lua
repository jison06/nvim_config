-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      diagnostics = {
        enable = false,
      },
      previewer = false,
    },
    buffers = {
      theme = "dropdown",
    },
    live_grep = {
      theme = "dropdown",
    },
    diagnostics = {
      theme = "dropdown",
    },
    symbols_outline = {
      theme = "dropdown",
    },
    document_symbols = {
      theme = "dropdown",
    },
    lsp_document_symbols = {
      theme = "dropdown",
    },
    lsp_workspace_symbols = {
      theme = "dropdown",
    },
    lsp_references = {
      theme = "dropdown",
    },
    lsp_code_actions = {
      theme = "dropdown",
    },
    lsp_definitions = {
      theme = "dropdown",
    },
    lsp_implementations = {
      theme = "dropdown",
    },
    lsp_type_definitions = {
      theme = "dropdown",
    },
    lsp_document_diagnostics = {
      theme = "dropdown",
    },
    lsp_workspace_diagnostics = {
      theme = "dropdown",
    },
  },
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
