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
require "workspace/tasks"
require "workspace/theme"
require "workspace/wm"

-- modes
require "modes/command"
require "modes/normal"
require "modes/multi"
require "modes/visual"
require "modes/terminal"

-- versioning
require "versioning/git"

-- editor
require "editor/cursors"
require "editor/format"
require "editor/highlight"
require "editor/lsp"
require "editor/macros"
require "editor/operators"
require "editor/textobj"
require "editor/search"
require "editor/suggestions"
require "editor/whitespace"

-- lang
require "lang/bash"
require "lang/css"
require "lang/docker"
require "lang/go"
require "lang/html"
require "lang/json"
require "lang/lua"
require "lang/python"
require "lang/rust"
require "lang/typescript"
require "lang/vim"
require "lang/xml"
require "lang/yaml"


registry.materialize()
