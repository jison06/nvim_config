if vim.g.vscode then
  -- VSCode extension
else
  require("jison")

  -- Install packer
  local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
  end
end

-- vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

-- vim.lsp.buf.format
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
