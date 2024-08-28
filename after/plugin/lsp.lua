-- vim.notify = require("notify")
-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  -- nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  nmap("<leader>ca", "<cmd>CodeActionMenu<CR>", "[C]ode [A]ction")

  -- nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  -- nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")
  nmap("<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>", "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- lsp diagnostic config
  vim.diagnostic.config({
    virtual_text = true, -- Turn off inline diagnostics
    underline = true,
    underline_highlight = true,
    colors = {
      -- Default colors
      Error = "#db4b4b",
      Warning = "#e0af68",
      Hint = "#0db9d7",
      Information = "#0db9d7",
    },
  })

  -- Use this if you want it to automatically show all diagnostics on the
  -- current line in a floating window. Personally, I find this a bit
  -- distracting and prefer to manually trigger it (see below). The
  -- CursorHold event happens when after `updatetime` milliseconds. The
  -- default is 4000 which is much too long
  -- vim.cmd("autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics(${bufnr})")
  -- vim.o.updatetime = 300

  -- Show all diagnostics on current line in floating window
  vim.api.nvim_set_keymap("n", "<Leader>d", ":lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
  -- Go to next diagnostic (if there are multiple on the same line, only shows
  -- one at a time in the floating window)
  vim.api.nvim_set_keymap("n", "]d", ":lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
  -- Go to prev diagnostic (if there are multiple on the same line, only shows
  -- one at a time in the floating window)
  vim.api.nvim_set_keymap(
    "n",
    "[d",
    ":lua vim.diagnostic.goto_prev()<CR>",
    { noremap = true, silent = true },
    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
      vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
  )

  -- keybind options
  -- local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  -- vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  -- vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
  -- vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  -- vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  -- -- vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  -- vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  -- vim.keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  -- vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  -- vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  -- vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  -- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  -- vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts) -- see outline on right hand side

  -- typescript specific vim.keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    vim.keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")      -- rename file and update imports
    vim.keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
    vim.keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>")    -- remove unused variables (not in youtube nvim video)
  end

  -- setup lsp_signature.nvim
  local onAttatchOpts = {
    log_path = vim.fn.expand("$HOME") .. "/tmp/sig.log",
    debug = true,
    hint_enable = false,
    handler_opts = { border = "single" },
    max_width = 80,
  }
  require("lsp_signature").on_attach(onAttatchOpts, bufnr)
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  clangd = {},
  -- pyright = {},
  rust_analyzer = {},
  -- tsserver = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  solargraph = {
    settings = {
      solargraph = {
        diagnostics = true,
        formatting = true,
      },
    },
  },
  elixirls = {},
  terraformls = {},
  eslint = {},

  -- dockerls = {},
  -- emmet_ls = {},
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    })
  end,
})

-- require("lspconfig").dartls.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   init_options = {
--     onlyAnalyzeProjectsWithOpenFiles = false,
--     suggestFromUnimportedLibraries = true,
--     closingLabels = true,
--     outline = true,
--     flutterOutline = false,
--   },
--   settings = {
--     dartls = {
--       completeFunctionCalls = true,
--       showTodos = true,
--     },
--   },
-- })
-- require("flutter-tools").setup({
--   lsp = {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   },
--   flutter_path = "/home/jison/.asdf/installs/flutter/3.3.10-stable/bin/flutter",
--   dart_sdk_path = "/home/jison/.asdf/installs/dart/2.18.7/dart-sdk/bin/dart",
-- })

-- Turn on lsp status information
require("fidget").setup()
-- Utility functions shared between progress reports for LSP and DAP

-- Setting up notifications
-- local client_notifs = {}
--
-- local function get_notif_data(client_id, token)
--   if not client_notifs[client_id] then
--     client_notifs[client_id] = {}
--   end
--
--   if not client_notifs[client_id][token] then
--     client_notifs[client_id][token] = {}
--   end
--
--   return client_notifs[client_id][token]
-- end
--
-- local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
--
-- local function update_spinner(client_id, token)
--   local notif_data = get_notif_data(client_id, token)
--
--   if notif_data.spinner then
--     local new_spinner = (notif_data.spinner + 1) % #spinner_frames
--     notif_data.spinner = new_spinner
--
--     notif_data.notification = vim.notify(nil, nil, {
--       hide_from_history = true,
--       icon = spinner_frames[new_spinner],
--       replace = notif_data.notification,
--     })
--
--     vim.defer_fn(function()
--       update_spinner(client_id, token)
--     end, 100)
--   end
-- end
--
-- local function format_title(title, client_name)
--   return client_name .. (#title > 0 and ": " .. title or "")
-- end
--
-- local function format_message(message, percentage)
--   return (percentage and percentage .. "%\t" or "") .. (message or "")
-- end
--
-- -- LSP integration
-- -- Make sure to also have the snippet with the common helper functions in your config!
--
-- vim.lsp.handlers["$/progress"] = function(_, result, ctx)
--   local client_id = ctx.client_id
--
--   local val = result.value
--
--   if not val.kind then
--     return
--   end
--
--   local notif_data = get_notif_data(client_id, result.token)
--
--   if val.kind == "begin" then
--     local message = format_message(val.message, val.percentage)
--
--     notif_data.notification = vim.notify(message, "info", {
--       title = format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
--       icon = spinner_frames[1],
--       timeout = false,
--       hide_from_history = false,
--     })
--
--     notif_data.spinner = 1
--     update_spinner(client_id, result.token)
--   elseif val.kind == "report" and notif_data then
--     notif_data.notification = vim.notify(format_message(val.message, val.percentage), "info", {
--       replace = notif_data.notification,
--       hide_from_history = false,
--     })
--   elseif val.kind == "end" and notif_data then
--     notif_data.notification = vim.notify(val.message and format_message(val.message) or "Complete", "info", {
--       icon = "",
--       replace = notif_data.notification,
--       timeout = 3000,
--     })
--
--     notif_data.spinner = nil
--   end
-- end
-- -- table from lsp severity to vim severity.
-- local severity = {
--   "error",
--   "warn",
--   "info",
--   "info", -- map both hint and info to info?
-- }
-- vim.lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
--   vim.notify(method.message, severity[params.type])
-- end
