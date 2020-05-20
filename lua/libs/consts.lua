--#################### ############# ####################
--#################### Consts Region ####################
--#################### ############# ####################

vim = vim
api = vim.api
env = vim.env
fn = vim.fn


vim_home = env["XDG_CONFIG_HOME"] .. "/nvim"
scripts_home = vim_home .. "/scripts"
bin_home = vim_home .. "/bin"
var_home = env["XDG_CACHE_HOME"] .. "/nvim"
