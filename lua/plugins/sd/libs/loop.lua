--#################### ########### ####################
--#################### Loop Region ####################
--#################### ########### ####################

local loop = vim.loop

local spawn = function (shell, opts, cb)

  local stdin = loop.new_pipe(false)
  local stdout = loop.new_pipe(false)
  local stderr = loop.new_pipe(false)
  local opts = {stdio = {stdin, stdout, stderr},
                args = opts.args or {}}
  local process = nil
  local out, errs = {}, {}
  local called = false
  local handles = {stdin, stdout, stderr, process}

  local call = function (val)
    if called then
      return
    end
    called = true
    for _, handle in ipairs(handles) do
      pcall(loop.close, handle)
    end
    cb(val)
  end

  local on_out = function (err, data)
    if data then
      table.insert(out, data)
    end
    if err then
      call()
      assert(false, err)
    end
  end

  local on_err = function (err, data)
    if data then
      table.insert(errs, data)
    end
    if err then
      call()
      assert(false, err)
    end
  end

  local on_exit = function (code, signal)
    call({code = code, 
          out = table.concat(out, ""),
          err = table.concat(errs, "")})
  end

  process, pid = loop.spawn(shell, opts, on_exit)

  if not process then
    call()
    assert(false, pid)
  end

  loop.read_start(stdout, on_out)
  loop.read_start(stderr, on_err)
  if opts.stream then
    loop.write(stdin, opts.stream)
  end
  loop.shutdown(stdin)

end


return {
  spawn = spawn,
}
