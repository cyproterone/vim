--#################### ############ ####################
--#################### Theme Region ####################
--#################### ############ ####################
local bindings = require "libs/bindings"
local registry = require "libs/registry"


local highlight = function (highlights)
  for group, terms in pairs(highlights) do
    local acc = {}
    for term, colour in pairs(terms) do
      table.insert(acc, term .. "=" .. colour)
    end
    local clause = table.concat(acc, " ")
    local hi = "highlight " .. group .. " " .. clause
    bindings.exec(hi)
    print(hi)
  end
end


local override = function (highlights)
  local hl = function ()
    highlight(highlights)
  end
  registry.auto("ColorScheme", hl)
end


return {
  highlight = highlight,
  override = override,
}
