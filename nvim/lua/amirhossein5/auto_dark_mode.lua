local job = require('plenary.job'):new({
  command = 'gsettings',
  args = { 'get', 'org.gnome.desktop.interface', 'color-scheme' },
})


if job:sync()[1] == "'prefer-dark'" then
  vim.opt.background = 'dark'
elseif job:sync()[1] == "'prefer-light'" then
  vim.opt.background = 'light'
end

