--#################### ########### ####################
--#################### Libs Region ####################
--#################### ########### ####################

require "libs/set"


--#################### ################ ####################
--#################### Workspace Region ####################
--#################### ################ ####################

require "workspace/keyboard"
require "workspace/misc"
require "workspace/navigation"
require "workspace/tasks"
require "workspace/theme"
require "workspace/tree"


--#################### ################# ####################
--#################### Versioning Region ####################
--#################### ################# ####################

require "versioning/git"


--#################### ############# ####################
--#################### Editor Region ####################
--#################### ############# ####################

require "editor/highlight"
require "editor/search"
require "editor/suggestions"


local actions = {
  keyboard(),
  misc(),
  navigation(),
  tasks(),
  theme(),
  tree(),
  git(),
  highlight(),
  search(),
  suggestions()
}
