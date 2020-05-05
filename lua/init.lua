--#################### Libs Region ####################
require "libs/consts"
local registry = require "libs/registry"


--#################### Init Region ####################

-- workspace
require "workspace/fm"
require "workspace/help"
require "workspace/keyboard"
require "workspace/misc"
require "workspace/mouse"
require "workspace/navigation"
require "workspace/proj"
require "workspace/tasks"
require "workspace/theme"
require "workspace/tree"
require "workspace/wm"
-- modes
require "modes/command"
require "modes/insert"
require "modes/normal"
require "modes/multi"
require "modes/visual"
-- versioning
require "versioning/git"
require "versioning/shared"
-- editor
require "editor/cursors"
require "editor/format"
require "editor/highlight"
require "editor/lsp"
require "editor/macros"
require "editor/textobj"
require "editor/search"
require "editor/suggestions"
require "editor/whitespace"


registry.materialize()
