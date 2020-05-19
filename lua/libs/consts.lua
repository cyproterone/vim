--#################### ############# ####################
--#################### Consts Region ####################
--#################### ############# ####################

vim = vim
api = vim.api
fn = vim.fn

vim_home = os.getenv("XDG_CONFIG_HOME") .. "/nvim"
scripts_home = vim_home .. "/scripts"
bin_home = vim_home .. "/bin"
var_home = os.getenv("XDG_CACHE_HOME") .. "/nvim"
