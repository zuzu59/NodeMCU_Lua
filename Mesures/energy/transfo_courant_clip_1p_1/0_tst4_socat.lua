--[[
tests connection reverse telnet commande à faire tourner sur le GATEWAY !

1ere console
pour une liaison directe: 
socat TCP-LISTEN:23043,fork,reuseaddr STDIO
pour une console sur un port:
socat TCP-LISTEN:23043,reuseaddr,fork TCP-LISTEN:23000,reuseaddr,bind=127.0.0.1

2e console
telnet -r localhost 23000
]]

--[[
tests connection reverse telnet commande à faire tourner sur le GATEWAY ET sur sa MACHINE !

1ere console sur le GATEWAY
socat TCP-LISTEN:23043,reuseaddr,fork TCP-LISTEN:23000,reuseaddr,bind=127.0.0.1

2e console sur sa MACHINE
ssh -L 23000:localhost:23000 user@GATEWAY

3e console sur sa MACHINE (~.return pour sortir !)
telnet -r localhost 23000
ou sur MAC
telnet -rN localhost 23000
]]


print("\n 0_tst4_socat.lua   zf200615.1937   \n")

local node, table, tmr, uwrite, tostring =
node, table, tmr, uart.write, tostring

local function telnet_listener(socket)
    local insert, remove, concat, heap, gc =
    table.insert, table.remove, table.concat, node.heap, collectgarbage
    local fifo1, fifo1l, fifo2, fifo2l = {}, 0, {}, 0
    local s -- s is a copy of the TCP socket if and only if sending is in progress
    
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
        --zzz
        if srv_rt~=nil then
            if console_port == srv_rt:getpeer() then
                s:send(rec)
            end
        end
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
    
    local function disconnect(_,zerr)
        node.output(nil)   
        gpio.write(zLED, gpio.HIGH)
        fifo1, fifo1l, fifo2, fifo2l, s = nil, nil, nil, nil, nil
        collectgarbage()   print("disconnected... "..zerr..", "..node.heap())
        if debug_rec~=nil then  debug_rec("disconnect, disconnected, "..zerr..", "..node.heap())   end
        
        local zlaps=tmr.now()/1000000-ztime_connect
        print("durée de connexion... "..zlaps)
        if debug_rec~=nil then  debug_rec("durée de connexion... "..zlaps..", "..node.heap())   end
        
        if zlaps>1 then
            if http_post~=nil then  http_post(influxdb_url,"energy,memory=socat_disconnected_"..yellow_id.." ram="..node.heap())  end
            rt_retry=rt_retry-1
            if rt_retry>=0 then
                local zstr="disconnect, reconnect 1x, "..node.heap()
                print(zstr)   if debug_rec~=nil then  debug_rec(zstr)   end
                rt_connect()
            end
        end
        
    end    
    
    
    --zzz
    local function zconnection(s)
        local zstr="zconnection, Welcome on ne devrait jamais passer par là to NodeMCU world."
        print(zstr)   if debug_rec~=nil then  debug_rec(zstr)   end
    end
        
    socket:on("connection",    zconnection)
    socket:on("receive",       receiveLine)
    socket:on("disconnection", disconnect)
    socket:on("sent",          sendLine)
    node.output(queueLine, 0)
    -- node.output(queueLine, 1)
end

--net.createServer(net.TCP, 180):listen(23, telnet_listener)
print("Revers telnet server running...\n")





function rt_connect()
    srv_rt = nil   collectgarbage()
    srv_rt = net.createConnection(net.TCP, 0)
    
    srv_rt:on("connection", function(sck)
        if debug_rec~=nil then  debug_rec("rt_connect, srv_rt:on, connected on, "..node.heap())   end
        ztime_connect=tmr.now()/1000000
        collectgarbage()
        --        if verbose then 
        gpio.write(zLED, gpio.LOW)
        print("connected on "..console_host..":"..console_port)
        print(node.heap())
        --        end
        if http_post~=nil then  http_post(influxdb_url,"energy,memory=socat_connected_"..yellow_id.." ram="..node.heap())  end
        telnet_listener(sck)
        print("Welcome to NodeMCU world.")
    end)
    
    srv_rt:connect(console_port,console_host)
    
    collectgarbage()
    -- if debug_rec~=nil then  debug_rec("rt_connect, try connect, "..node.heap())   end
    
    --    if verbose then
    gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH)
    print("trying connect to "..console_host..":"..console_port)
    print(node.heap())
    --    end
    if http_post~=nil then  http_post(influxdb_url,"energy,memory=socat_try_con_"..yellow_id.." ram="..node.heap())  end        
end




tmr_socat1=tmr.create()
tmr_socat1:alarm(15*1000, tmr.ALARM_AUTO , function()
    
    if http_post~=nil then  http_post(influxdb_url,"energy,memory=tmr_socat1_"..yellow_id.." ram="..node.heap())  end        
    
    rt_retry=3
    -- if verbose then gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH) end    
    if srv_rt~=nil then
        
        -- if http_post~=nil then  http_post(influxdb_url,"energy,memory=srv_rt_no_nil_"..yellow_id.." ram="..node.heap())  end        
        
        if console_port ~= srv_rt:getpeer() then
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
rt_connect()
print(srv_rt)
print(srv_rt:getpeer())

rt_connect=nil
telnet_listener=nil
disconnect=nil

total_allocated, estimated_used = node.egc.meminfo()
print(total_allocated, estimated_used)

print(console_port)

srv_rt = nil   collectgarbage()

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
