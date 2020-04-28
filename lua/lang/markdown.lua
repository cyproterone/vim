local bindings = require "libs/bindings"

local plugins = {}
local defer = {}

--#################### Lang Markdown ####################

-- :InstantMarkdownPreview
-- :InstantMarkdownStop
table.insert(plugins, {"suan/vim-instant-markdown", ["for"] = "markdown"})
local lang_conf = function ()

  bindings.let("instant_markdown_open_to_the_world", true)
  bindings.let("instant_markdown_port", 8000)
  bindings.let("instant_markdown_autoscroll", true)

  -- block scripts
  bindings.let("instant_markdown_allow_unsafe_content", false)

end
table.insert(defer, lang_conf)


return {
  plugins = plugins,
  defer = defer,
}

