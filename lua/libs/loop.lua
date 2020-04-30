--#################### ########### ####################
--#################### Loop Region ####################
--#################### ########### ####################

local loop = vim.loop

local spawn = function (shell, stream, cb)

  local stdin = loop.new_pipe()
  local stdout = loop.new_pipe()
  local stderr = loop.new_pipe()
  local opts = {stdio = {stdin, stdout, stderr}}
  local process
  local out, err = {}, {}
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
      table.insert(err, data)
    end
    if err then
      call()
      assert(false, err)
    end
  end

  local on_exit = function (code, signal)
    call({stdout = out, stderr = err})
  end

  process, pid = loop.spawn(shell, opts, on_spawn)
  if not process then
    assert(false, pid)
    return
  end

  loop.read_start(stdout, on_out)
  loop.read_start(stderr, on_err)
  if stream then
    loop.write(stdin, stream)
  end
  loop.shutdown(stdin)

end


return {
  exec = exec,
}
