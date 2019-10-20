
collectgarbage("setmemlimit", 4)
websocket.createServer(80, function (socket)
  local data
  node.output(function (msg)
    return socket.send(msg, 1)
  end, 1)
  print("New websocket client connected")

  function socket.onmessage(payload, opcode)
    if opcode == 1 then
      if payload == "ls" then
        local list = file.list()
        local lines = {}
        for k, v in pairs(list) do
          lines[#lines + 1] = k .. "\0" .. v
        end
        socket.send(table.concat(lines, "\0"), 2)
        return
        -- standard js websockets do not support ping/pong opcodes so we have to
        -- fake it
      elseif payload == "ping" then
        socket.send("pong", 2)
        return
      end
      local command, name = payload:match("^([a-z]+):(.*)$")
      if command == "load" then
        file.open(name, "r")
        socket.send(file.read(), 2)
        file.close()
      elseif command == "save" then
        file.open(name, "w")
        file.write(data)
        data = nil
        file.close()
        print("saved:"..name)
      elseif command == "compile" then
        node.compile(name)
        print("compiled:"..name)
      elseif command == "run" then
        dofile(name)
      elseif command == "eval" then
        local fn, success, err
        fn, err = loadstring(data, name)
        if not fn then
          fn = loadstring("print(" .. data .. ")", name)
        end
        data = nil
        if fn then
          success, err = pcall(fn)
        end
        if not success then
          print(err)
        end
      else
        print("Invalid command: " .. command)
      end
    elseif opcode == 2 then
      data = payload
    end
    collectgarbage("setmemlimit", 4)
  end
end)
