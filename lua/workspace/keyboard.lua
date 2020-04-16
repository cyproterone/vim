require "libs/set"


local plugins = {}
local defer = {}

--#################### Keyboard Region ####################

-- enable smartcase
local smartcase = function ()
  bindings.set("ignorecase")
  bindings.set("smartcase")
end
table.insert(defer, smartcase)


local normalize_keystrokes = function ()
  -- allow nav keys to wrap around
  bindings.set("whichwrap", "h,l,<,>", [[+=]])

  -- normalize backspace in insertion mode
  bindings.set("backspace", "indent,eol,start")
end
table.insert(defer, normalize_keystrokes)


return {
  plugins = plugins,
  defer = defer,
}
