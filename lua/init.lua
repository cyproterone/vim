--#################### Libs Region ####################
require "libs/consts"
local ftp = require "libs/ftp"
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
require "versioning/vc"

-- editor
require "editor/delimiters"
require "editor/fmt"
require "editor/highlight"
require "editor/lint"
require "editor/lsp"
require "editor/search"
require "editor/suggestions"
require "editor/syntax"
require "editor/undo"
require "editor/whitespace"

require "operators/_extern"
require "operators/move"
require "operators/replace"
require "operators/search"
require "operators/sort"
require "operators/unimpaired"

require "textobject/_extern"
require "textobject/entire"
require "textobject/indent"
require "textobject/line"

-- lang
require "lang/_lang"
require "lang/_fmt"
require "lang/_lint"
require "lang/bash"
require "lang/cfg"
require "lang/css"
require "lang/docker"
require "lang/go"
require "lang/html"
require "lang/json"
require "lang/lua"
require "lang/markdown"
require "lang/prolog"
require "lang/python"
require "lang/rust"
require "lang/sql"
require "lang/typescript"
require "lang/vim"
require "lang/xml"
require "lang/yaml"


registry.materialize(ftp.materialize)
