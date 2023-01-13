# NVIM CONFIG

# IMPORTANT

- TO GET AUTOFORMATTING WORKING USING MASON & NULL-LS, YOU NEED TO HAVE RUN :Mason AND HAVE INSTALLED THE FORMATTERS YOU WANT
- ALSO PUT THE FORMATTERS IN `./after/plugin/null_ls.lua`

## Installation

0. If ripgrep isn't installed run `$ sudo apt-get install ripgrep`
1. Clone the repo
2. Navigate to `lua/jison/packer.lua`
3. Run `:so` and `:PackerSync`
4. Restart nvim

## Helpful shortcuts

`<leader> = space`

- `<leader>fe` - file explorer
- `<leader>ff` - Format
- `<leader>p` - run prettier
- `<leader>?` - find recently opened files
- `<leader>space` - find existing buffers
- `<leader>/` - fuzzy search in current buffer
- `<leader>sf` - search file
- `<leader>sh` - search help docs
- `<leader>sh` - grep string
- `<leader>sg` - grep
- `<leader>sd` - look through all errors and warnings
