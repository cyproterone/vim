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
  local called = false
  local handles = {stdin, stdout, stderr, process}

  local call = function (val)
    if called then
      return
    end
    called = true
    for _, handle in ipairs(handles) do
      pcall(uv.close, handle)
    end
    cb(val)
  end

  local on_shutdown = function (err)
    if err then
      call()
      assert(false, err)
    end
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

  process, pid = uv.spawn(shell, opts, on_exit)

  if not process then
    call()
    assert(false, pid)
  end

  uv.read_start(stdout, on_out)
  uv.read_start(stderr, on_err)
  if opts.stream then
    uv.write(stdin, opts.stream)
  end
  uv.shutdown(stdin, on_shutdown)

end


-- WARN: doesn't allow tables, or closures :<
local dispatch = function (worker, args, callback)
  local work = uv.new_work(worker, callback)
  assert(uv.queue_work(work, unpack(args)))
end


return {
  spawn = spawn,
  dispatch = dispatch,
}
