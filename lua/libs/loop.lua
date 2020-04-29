--#################### ########### ####################
--#################### Loop Region ####################
--#################### ########### ####################

local loop = vim.loop

local spawn = function (shell, stream)

  local stdin = loop.new_pipe()
  local stdout = loop.new_pipe()
  local stderr = loop.new_pipe()

  local on_write_end = function (err)
    loop.close(stdin)
  end

  local on_out = function (err, data)
    if not data then
      loop.close(stdout)
    end
  end

  local on_err = function (err, data)
    if not data then
      loop.close(stderr)
    end
  end

  local process
  local on_exit = function (code, signal)
    loop.close(process)
  end

  local opts = {stdio = {stdin, stdout, stderr}}
  process = assert(loop.spawn(shell, opts, on_spawn))

  loop.read_start(stdout, on_out)
  loop.read_start(stderr, on_err)

  if stream
  then
    loop.write(stdin, stream)
  end

  loop.shutdown(stdin, on_write_end)

  loop.close(process, on_exit)

end


return {
  exec = exec,
}
