--#################### ############ ####################
--#################### Theme Region ####################
--#################### ############ ####################
local bindings = require "libs/bindings"
local registry = require "libs/registry"


local override = function (highlights)


  local hl = function ()
    for group, terms in ipairs(highlight) do
      local acc = {}
      for term, colour in ipairs(terms) do
        table.insert(acc, term .. " = " .. colour)
      end
      local clause = table.concat(acc, " ")
      local hi = "highlight " .. group .. " " .. clause
      print(hi)
    end
  end

  registry.auto("ColorScheme", hl)

end


return {
  override = override
}

