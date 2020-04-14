""#################### ########### ####################
""#################### Init Region ####################
""#################### ########### ####################

" drop vi compatibility
set nocompatible

let $vimrcbase="$HOME/.vim"


""#################### ########### ####################
""#################### Libs Region ####################
""#################### ########### ####################

source $vimrcbase/lib/lib.vim


""#################### ################ ####################
""#################### Workspace Region ####################
""#################### ################ ####################

source $vimrcbase/workspace/help.vim
source $vimrcbase/workspace/keyboard.vim
source $vimrcbase/workspace/misc.vim
source $vimrcbase/workspace/mouse.vim
source $vimrcbase/workspace/navigation.vim
source $vimrcbase/workspace/theme.vim
source $vimrcbase/workspace/tree.vim
source $vimrcbase/workspace/wm.vim


""#################### ################# ####################
""#################### Versioning Region ####################
""#################### ################# ####################

source $vimrcbase/versioning/git.vim


""#################### ############# ####################
""#################### Editor Region ####################
""#################### ############# ####################

source $vimrcbase/editor/highlight.vim
source $vimrcbase/editor/search.vim
source $vimrcbase/editor/suggestions.vim
source $vimrcbase/editor/whitespace.vim


""#################### ########### ####################
""#################### Lang Region ####################
""#################### ########### ####################
