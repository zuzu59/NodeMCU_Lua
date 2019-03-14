-- Serveur telnet pour connexion en remote WIFI, NOUVELLE VERSION !
-- source: https://github.com/nodemcu/nodemcu-firmware/blob/master/lua_examples/telnet/telnet.lua

print("\n telnet_srv2.lua   zf181215.1326   \n")

local node, table, tmr, wifi, uwrite,     tostring =
      node, table, tmr, wifi, uart.write, tostring

local function telnet_listener(socket)
  local insert,       remove,       concat,       heap,      gc   =
        table.insert, table.remove, table.concat, node.heap, collectgarbage
  local fifo1, fifo1l, fifo2, fifo2l = {}, 0, {}, 0
  local s -- s is a copy of the TCP socket if and only if sending is in progress
  local wdclr, cnt = tmr.wdclr, 0
  local function debug(fmt, ...)
    if (...) then fmt = fmt:format(...) end
    uwrite(0, "\r\nDBG: ",fmt,"\r\n" )
    cnt = cnt + 1
    if cnt % 10 then wdclr() end
  end

  local function flushGarbage()
    if heap() < 13440 then gc() end
  end

  local function sendLine()
     if not s then return end

      if fifo2l + fifo1l == 0 then -- both FIFOs empty, so clear down s
        s = nil
        return
    end
    flushGarbage()
    if #fifo2 < 4 then -- Flush FIFO1 into FIFO2
      insert(fifo2,concat(fifo1))
      fifo2l, fifo1, fifo1l = fifo2l + fifo1l, {}, 0
    end
    local rec =  remove(fifo2,1)        .. (remove(fifo2,1) or '') ..
                (remove(fifo2,1) or '') .. (remove(fifo2,1) or '')
    fifo2l = fifo2l - #rec
    flushGarbage()
    s:send(rec)
  end

  local F1_SIZE = 256

  local function queueLine(str)
    while #str > 0 do  -- this is because str might be longer than the packet size!
      local k, l = F1_SIZE - fifo1l, #str
      local chunk
      if #fifo1 >= 32 or (k < l and k < 16) then
        insert(fifo2, concat(fifo1))
        fifo2l, fifo1, fifo1l, k = fifo2l + fifo1l, {}, 0, F1_SIZE
      end
      if l > k+16 then -- also tolerate a size overrun of 16 bytes to avoid a split
        chunk, str = str:sub(1,k), str:sub(k+1)
      else
        chunk, str = str, ''
      end
      insert(fifo1, chunk)
      fifo1l = fifo1l + #chunk
    end
    if not s and socket then
      s = socket
      sendLine()
    else
      flushGarbage()
    end
  end

  local function receiveLine(s, line)
    node.input(line)
  end

  local function disconnect(s)
    fifo1, fifo1l, fifo2, fifo2l, s = {}, 0, {}, 0, nil
    node.output(nil)
  end

  socket:on("receive",       receiveLine)
  socket:on("disconnection", disconnect)
  socket:on("sent",          sendLine)
  node.output(queueLine, 0)
end

net.createServer(net.TCP, 180):listen(23, telnet_listener)
print("Telnet server running...\nUsage: telnet -rN ip\n")
