""#################### ########### ####################
""#################### Init Region ####################
""#################### ########### ####################

" drop vi compatibility
set nocompatible

let $vimrc_dir=expand('$HOME/.vim')


""#################### ########### ####################
""#################### Libs Region ####################
""#################### ########### ####################

source $vimrc_dir/lib/lib.vim
source $vimrc_dir/lib/keys.vim


""#################### ################ ####################
""#################### Workspace Region ####################
""#################### ################ ####################

source $vimrc_dir/workspace/keyboard.vim
source $vimrc_dir/workspace/misc.vim
source $vimrc_dir/workspace/mouse.vim
source $vimrc_dir/workspace/navigation.vim
source $vimrc_dir/workspace/tasks.vim
source $vimrc_dir/workspace/theme.vim
source $vimrc_dir/workspace/tree.vim
source $vimrc_dir/workspace/wm.vim


""#################### ################# ####################
""#################### Versioning Region ####################
""#################### ################# ####################

source $vimrc_dir/versioning/git.vim


""#################### ############# ####################
""#################### Editor Region ####################
""#################### ############# ####################

source $vimrc_dir/editor/highlight.vim
source $vimrc_dir/editor/search.vim
source $vimrc_dir/editor/suggestions.vim
source $vimrc_dir/editor/whitespace.vim


""#################### ########### ####################
""#################### Lang Region ####################
""#################### ########### ####################
