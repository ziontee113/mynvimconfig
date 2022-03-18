local colorscheme = "gruvbox"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme) --> protected call example
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
