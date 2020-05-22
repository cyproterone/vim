--#################### ########### ####################
--#################### Loop Region ####################
--#################### ########### ####################
local a = require "libs/async"
local uv = vim.loop

local spawn = function (shell, opts, cb)

  local stdin = uv.new_pipe(false)
  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)
  local args = {stdio = {stdin, stdout, stderr},
                args = opts.args or {}}

  local process, pid = nil, nil
  local out, errs = {}, {}

  process, pid = uv.spawn(shell, args, function (code)
    local handles = {stdin, stdout, stderr, process}
    for _, handle in ipairs(handles) do
      pcall(uv.close, handle)
    end
    cb(code, table.concat(out, ""), table.concat(errs, ""))
  end)
  assert(process, pid)

  uv.read_start(stdout, function (err, data)
    assert(not err, err)
    if data then
      table.insert(out, data)
    end
  end)

  uv.read_start(stderr, function (err, data)
    assert(not err, err)
    if data then
      table.insert(errs, data)
    end
  end)

  if opts.stream then
    uv.write(stdin, opts.stream, function (err)
      assert(not err, err)
      uv.shutdown(stdin, function (err)
        assert(not err, err)
      end)
    end)
  end

end


-- required due to textlock
local main = function (f)
  vim.schedule(f)
end


return {
  spawn = a.wrap(spawn),
  main = main,
}

