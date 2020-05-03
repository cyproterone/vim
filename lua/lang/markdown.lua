local bindings = require "libs/bindings"local registry = require "libs/registry"


--#################### Lang Markdown ####################

-- :InstantMarkdownPreview
-- :InstantMarkdownStop
registry.install({"suan/vim-instant-markdown", ["for"] = "markdown"})
local lang_conf = function ()

  bindings.let("instant_markdown_open_to_the_world", true)
  bindings.let("instant_markdown_port", 8000)
  bindings.let("instant_markdown_autoscroll", true)

  -- block scripts
  bindings.let("instant_markdown_allow_unsafe_content", false)

end
registry.defer(lang_conf)


return {
  plugins = plugins,
  defer = defer,
  functions = functions,
}

