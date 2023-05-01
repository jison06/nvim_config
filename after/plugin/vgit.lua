require("vgit").setup({
  keymaps = {
    vim.keymap.set("n", "<C-k>", ":lua require('vgit').hunk_up()<CR>", { silent = true, desc = "vgit hunk up" }),
    vim.keymap.set("n", "<C-j>", ":lua require('vgit').hunk_down()<CR>", { silent = true, desc = "vgit hunk_down"}),
    vim.keymap.set("n", "<C-j>", ":lua require('vgit').buffer_hunk_stage<CR>", { silent = true, desc = "vgit buffer hunk stage"}),
    vim.keymap.set("n", "<leader>gr", ":lua require('vgit').buffer_hunk_reset()<CR>", {silent = true, desc = "vgit buffer_hunk_reset"}),
    vim.keymap.set("n", "<leader>gp", ":lua require('vgit').buffer_hunk_preview()<CR>", {silent = true, desc = "vgit buffer_hunk_preview"}),
    vim.keymap.set("n", "<leader>gb", ":lua require('vgit').buffer_blame_preview()<CR>", {silent = true, desc = "vgit buffer_blame_preview"}),
    vim.keymap.set("n", "<leader>gf", ":lua require('vgit').buffer_diff_preview()<CR>", {silent = true, desc = "vgit buffer_diff_preview"}),
    vim.keymap.set("n", "<leader>gh", ":lua require('vgit').buffer_history_preview()<CR>", {silent = true, desc = "vgit buffer_history_preview"}),
    vim.keymap.set("n", "<leader>gu", ":lua require('vgit').buffer_reset()<CR>", {silent = true, desc = "vgit buffer_reset"}),
    vim.keymap.set("n", "<leader>gg", ":lua require('vgit').buffer_gutter_blame_preview()<CR>", {silent = true, desc = "vgit buffer_gutter_blame_preview"}),
    vim.keymap.set("n", "<leader>glu", ":lua require('vgit').buffer_hunks_preview()<CR>", {silent = true, desc = "vgit buffer_hunks_preview"}),
    vim.keymap.set("n", "<leader>gls", ":lua require('vgit').project_hunks_staged_preview()<CR>", {silent = true, desc = "vgit project_hunks_staged_preview"}),
    vim.keymap.set("n", "<leader>gd", ":lua require('vgit').project_diff_preview()<CR>", {silent = true, desc = "vgit project_diff_preview"}),
    vim.keymap.set("n", "<leader>gq", ":lua require('vgit').project_hunks_qf()<CR>", {silent = true, desc = "vgit project_hunks_qf"}),
    vim.keymap.set("n", "<leader>gx", ":lua require('vgit').toggle_diff_preference()<CR>", {silent = true, desc = "vgit toggle_diff_preference"}),
  },
  settings = {
    git = {
      cmd = "git", -- optional setting, not really required
      fallback_cwd = vim.fn.expand("$HOME"),
      fallback_args = {
        "--git-dir",
        vim.fn.expand("$HOME/dots/yadm-repo"),
        "--work-tree",
        vim.fn.expand("$HOME"),
      },
    },
    hls = {
      GitBackground = "Normal",
      GitHeader = "NormalFloat",
      GitFooter = "NormalFloat",
      GitBorder = "LineNr",
      GitLineNr = "LineNr",
      GitComment = "Comment",
      GitSignsAdd = {
        gui = nil,
        fg = "#d7ffaf",
        bg = nil,
        sp = nil,
        override = false,
      },
      GitSignsChange = {
        gui = nil,
        fg = "#7AA6DA",
        bg = nil,
        sp = nil,
        override = false,
      },
      GitSignsDelete = {
        gui = nil,
        fg = "#e95678",
        bg = nil,
        sp = nil,
        override = false,
      },
      GitSignsAddLn = "DiffAdd",
      GitSignsDeleteLn = "DiffDelete",
      GitWordAdd = {
        gui = nil,
        fg = nil,
        bg = "#5d7a22",
        sp = nil,
        override = false,
      },
      GitWordDelete = {
        gui = nil,
        fg = nil,
        bg = "#960f3d",
        sp = nil,
        override = false,
      },
    },
    live_blame = {
      enabled = true,
      format = function(blame, git_config)
        local config_author = git_config["user.name"]
        local author = blame.author
        if config_author == author then
          author = "You"
        end
        local time = os.difftime(os.time(), blame.author_time) / (60 * 60 * 24 * 30 * 12)
        local time_divisions = {
          { 1, "years" },
          { 12, "months" },
          { 30, "days" },
          { 24, "hours" },
          { 60, "minutes" },
          { 60, "seconds" },
        }
        local counter = 1
        local time_division = time_divisions[counter]
        local time_boundary = time_division[1]
        local time_postfix = time_division[2]
        while time < 1 and counter ~= #time_divisions do
          time_division = time_divisions[counter]
          time_boundary = time_division[1]
          time_postfix = time_division[2]
          time = time * time_boundary
          counter = counter + 1
        end
        local commit_message = blame.commit_message
        if not blame.committed then
          author = "You"
          commit_message = "Uncommitted changes"
          return string.format(" %s • %s", author, commit_message)
        end
        local max_commit_message_length = 255
        if #commit_message > max_commit_message_length then
          commit_message = commit_message:sub(1, max_commit_message_length) .. "..."
        end
        return string.format(
          " %s, %s • %s",
          author,
          string.format("%s %s ago", time >= 0 and math.floor(time + 0.5) or math.ceil(time - 0.5), time_postfix),
          commit_message
        )
      end,
    },
    live_gutter = {
      enabled = true,
      edge_navigation = true, -- This allows users to navigate within a hunk
    },
    authorship_code_lens = {
      enabled = true,
    },
    scene = {
      diff_preference = "unified", -- unified or split
      keymaps = {
        quit = "qu",
      },
    },
    diff_preview = {
      keymaps = {
        buffer_stage = "S",
        buffer_unstage = "U",
        buffer_hunk_stage = "s",
        buffer_hunk_unstage = "u",
        toggle_view = "t",
      },
    },
    project_diff_preview = {
      keymaps = {
        buffer_stage = "s",
        buffer_unstage = "u",
        buffer_hunk_stage = "gs",
        buffer_hunk_unstage = "gu",
        buffer_reset = "r",
        stage_all = "S",
        unstage_all = "U",
        reset_all = "R",
      },
    },
    project_commit_preview = {
      keymaps = {
        save = "S",
      },
    },
    signs = {
      priority = 10,
      definitions = {
        GitSignsAddLn = {
          linehl = "GitSignsAddLn",
          texthl = nil,
          numhl = nil,
          icon = nil,
          text = "",
        },
        GitSignsDeleteLn = {
          linehl = "GitSignsDeleteLn",
          texthl = nil,
          numhl = nil,
          icon = nil,
          text = "",
        },
        GitSignsAdd = {
          texthl = "GitSignsAdd",
          numhl = nil,
          icon = nil,
          linehl = nil,
          text = "┃",
        },
        GitSignsDelete = {
          texthl = "GitSignsDelete",
          numhl = nil,
          icon = nil,
          linehl = nil,
          text = "┃",
        },
        GitSignsChange = {
          texthl = "GitSignsChange",
          numhl = nil,
          icon = nil,
          linehl = nil,
          text = "┃",
        },
      },
      usage = {
        screen = {
          add = "GitSignsAddLn",
          remove = "GitSignsDeleteLn",
        },
        main = {
          add = "GitSignsAdd",
          remove = "GitSignsDelete",
          change = "GitSignsChange",
        },
      },
    },
    symbols = {
      void = "⣿",
    },
  },
})
