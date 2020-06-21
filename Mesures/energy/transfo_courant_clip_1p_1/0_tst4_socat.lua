--[[
tests connection reverse telnet commande à faire tourner sur le GATEWAY !

1ere console
pour une liaison directe: 
socat TCP-LISTEN:23064,fork,reuseaddr STDIO
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


print("\n 0_tst4_socat.lua   zf200621.1352   \n")

local node, table, tmr, uwrite, tostring =
node, table, tmr, uart.write, tostring

local function telnet_listener(socket)
    print("................telnet_listener")
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
    
    local function disconnect(_,zerr)
        node.output(nil)
        print("................disconnect")
        
        if socket~=nil then
            -- if http_post~=nil then  http_post(influxdb_url,"energy,memory=srv_rt_no_nil_"..yellow_id.." ram="..node.heap())  end        
            print("................disconnect 2e", socket, socket:getpeer())
        end
        
        gpio.write(zLED, gpio.HIGH)
        fifo1, fifo1l, fifo2, fifo2l, s = nil, nil, nil, nil, nil
        collectgarbage()   
        print("disconnected... "..zerr..", "..node.heap())
        -- if debug_rec~=nil then  debug_rec("disconnect, disconnected, "..zerr..", "..node.heap())   end
        rt_connect()
        end    

    --zzz
    local function zconnection(s)
        print("socket: ",socket)
        if socket~=nil then
            -- if http_post~=nil then  http_post(influxdb_url,"energy,memory=srv_rt_no_nil_"..yellow_id.." ram="..node.heap())  end        
            print(socket:getpeer())
        end
        
        local zstr="zconnection, Oups, on ne devrait jamais passer par là to NodeMCU world."
        print(zstr)   if debug_rec~=nil then  debug_rec(zstr)   end
        socket=nil
    end
    
    socket:on("connection",    zconnection)
    socket:on("receive",       receiveLine)
    socket:on("disconnection", disconnect)
    socket:on("sent",          sendLine)
    
    node.output(queueLine, 0)
    -- print(queueLine, 0)
end






function rt_connect()
    print("................rt_connect")
    collectgarbage()
    local zlaps=tmr.now()/1000000-ztime_connect
    print("durée de retry connect... "..zlaps)
    -- if debug_rec~=nil then  debug_rec("durée de retry connect... "..zlaps..", "..node.heap())   end
    if zlaps>1.5 then
        local zstr="trying connect to "..console_host..":"..console_port..", "..node.heap()
        -- if debug_rec~=nil then  debug_rec(zstr)   end
        if verbose==verbose then
            gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH)
            print(zstr)   
        end
        if http_post~=nil then  http_post(influxdb_url,"energy,memory=socat_try_con_"..yellow_id.." ram="..node.heap())  end
        ztime_connect=tmr.now()/1000000
        
        srv_rt=nil
        srv_rt = net.createConnection(net.TCP, 0)

        srv_rt:on("connection", function(sck)
            print("................connection")
            if debug_rec~=nil then  debug_rec("rt_connect, srv_rt:on, connected on, "..node.heap())   end
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
    else
        print("on ne se reconnecte pas vite 1x...")
    end
    collectgarbage()    
end




function rt_launch()
    if http_post~=nil then  http_post(influxdb_url,"energy,memory=tmr_socat1_"..yellow_id.." ram="..node.heap())  end
    if srv_rt~=nil then
        -- if http_post~=nil then  http_post(influxdb_url,"energy,memory=srv_rt_no_nil_"..yellow_id.." ram="..node.heap())  end        
        if console_port ~= srv_rt:getpeer() then
            rt_connect()
        end
    else
        rt_connect()
    end
end


-- tmr_socat1=tmr.create()
-- tmr_socat1:alarm(15*1000, tmr.ALARM_AUTO , rt_launch)





ztime_connect=tmr.now()/1000000

-- rt_launch()

print("Revers telnet server running...\n")
