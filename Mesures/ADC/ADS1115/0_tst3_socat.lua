--[[
tests connection reverse telnet
commande à faire tourner sur le serveur

1ere console
pour une liaison directe: 
socat TCP-LISTEN:23047,fork,reuseaddr STDIO
pour une console sur un port:
socat TCP-LISTEN:23047,reuseaddr,fork TCP-LISTEN:23000,reuseaddr,bind=127.0.0.1

2e console
telnet -r localhost 23000
]]

print("\n 0_tst3_socat.lua   zf200229.2243   \n")

local node, table, tmr, uwrite, tostring =
      node, table, tmr, uart.write, tostring

local function telnet_listener(socket)
  local insert, remove, concat, heap, gc =
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
    --fifo1, fifo1l, fifo2, fifo2l, s = {}, 0, {}, 0, nil
    fifo1, fifo1l, fifo2, fifo2l, s = nil, nil, nil, nil, nil
    --insert, remove, concat, heap, gc = nil, nil, nil, nil, nil
    --wdclr, cnt = nil, nil
    node.output(nil)
    print("disconnected...")
--    print("rt_retry:",rt_retry)
--    rt_retry=rt_retry-1
--    print("rt_retry:",rt_retry)
--    if rt_retry>=0 then
        print("on ressaie en vitesse une fois ;-)")
        rt_connect()
--    end    
end

  --zzz
  local function zconnection(s)
    print("Welcome on ne devrait jamais passer par là to NodeMCU world.")
  end

  socket:on("connection",    zconnection)
  socket:on("receive",       receiveLine)
  socket:on("disconnection", disconnect)
  socket:on("sent",          sendLine)
  node.output(queueLine, 0)
end

--net.createServer(net.TCP, 180):listen(23, telnet_listener)
print("Revers telnet server running...\n")





function rt_connect()
    if verbose then
        gpio.write(zLED, gpio.HIGH)
        print("trying connect to "..console_host..":"..console_port)
        print(node.heap()) collectgarbage() print(node.heap())
    end
    srv_rt = nil   srv_rt = net.createConnection(net.TCP, 0)
    srv_rt:on("connection", function(sck)
        if verbose then 
            print("connected on "..console_host..":"..console_port)
            print(node.heap()) collectgarbage() print(node.heap())
        end
        telnet_listener(sck)
        print("Welcome to NodeMCU world.")
    end)
    srv_rt:connect(console_port,console_host)
end

tmr_socat1=tmr.create()
tmr_socat1:alarm(5*1000, tmr.ALARM_AUTO , function()
    rt_retry=1   
    if verbose then gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH) end
    
    if srv_rt~=nil then
        if console_port == srv_rt:getpeer() then
            --cela tourne...
            if verbose then gpio.write(zLED, gpio.LOW) end
        else
            --on relance...
            rt_connect()
        end
    else
        --on relance...
        rt_connect()
    end
end)

rt_retry=3
rt_connect()






--[[
tmr_socat1:unregister()
for k,v in pairs(_G) do print(k,v) end

print(srv_rt:getpeer())

srv_rt:connect(console_port,console_host)

gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)
if console_port == srv_rt:getpeer() then
    gpio.write(zLED, gpio.LOW)
else
    gpio.write(zLED, gpio.HIGH)
end


]]
