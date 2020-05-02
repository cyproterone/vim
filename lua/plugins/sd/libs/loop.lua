--#################### ########### ####################
--#################### Loop Region ####################
--#################### ########### ####################

local uv = vim.loop

local spawn = function (shell, opts, cb)

  local stdin = uv.new_pipe(false)
  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)
  local opts = {stdio = {stdin, stdout, stderr},
                args = opts.args or {}}
  local process = nil
  local out, errs = {}, {}
  local handles = {stdin, stdout, stderr, process}

  local call = function (val)
    for _, handle in ipairs(handles) do
      pcall(uv.close, handle)
    end
    cb(val)
  end

  local on_write = function (err)
    assert(not err, err)
  end

  local on_out = function (err, data)
    assert(not err, err)
    if data then
      table.insert(out, data)
    end
  end

  local on_err = function (err, data)
    assert(not err, err)
    if data then
      table.insert(errs, data)
    end
  end

  local on_exit = function (code, signal)
    call({code = code, 
          out = table.concat(out, ""),
          err = table.concat(errs, "")})
  end

  process, pid = uv.spawn(shell, opts, on_exit)
  assert(process, pid)

  uv.read_start(stdout, on_out)
  uv.read_start(stderr, on_err)
  if opts.stream then
    uv.write(stdin, opts.stream, on_write)
  end
  uv.shutdown(stdin, on_write)

end


-- required due to textlock
local main = function (f)
  vim.schedule(f)
end


return {
  spawn = spawn,
  main = main,
}
