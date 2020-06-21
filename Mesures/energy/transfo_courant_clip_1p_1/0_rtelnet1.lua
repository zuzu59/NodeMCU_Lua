-- script telnet pour le socat

function telnet_listener(socket)
    print("\n 0_rtelnet1.lua   zf200621.1603   \n")
    
    node, table, tmr, uwrite, tostring =
    node, table, tmr, uart.write, tostring
    
    print("................telnet_listener")
    insert, remove, concat, heap, gc =
    table.insert, table.remove, table.concat, node.heap, collectgarbage
    fifo1, fifo1l, fifo2, fifo2l = {}, 0, {}, 0
    -- local s -- s is a copy of the TCP socket if and only if sending is in progress
    
    function flushGarbage()
        if heap() < 13440 then gc() end
    end
    
    function sendLine()
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
    
    function queueLine(str)
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
    
    function receiveLine(s, line)
        node.input(line)
    end
    
    function disconnect(_,zerr)
        node.output(nil)
        gpio.write(zLED, gpio.HIGH)
        print("................disconnect")
        
        if socket~=nil then
            -- if http_post~=nil then  http_post(influxdb_url,"energy,memory=srv_rt_no_nil_"..yellow_id.." ram="..node.heap())  end        
            print("................disconnect 2e", socket, socket:getpeer())
        end
        
        -- fifo1, fifo1l, fifo2, fifo2l, s = nil, nil, nil, nil, nil
        print("disconnected... "..zerr..", "..node.heap())
        -- if debug_rec~=nil then  debug_rec("disconnect, disconnected, "..zerr..", "..node.heap())   end
        -- telnet_listener=nil
        
        
        node, table, tmr, uwrite, tostring = nil, nil, nil, nil, nil
        insert, remove, concat, heap, gc = nil, nil, nil, nil, nil
        fifo1, fifo1l, fifo2, fifo2l = nil, nil, nil, nil
        s = nil
        
        flushGarbage = nil
        sendLine = nil
        queueLine = nil
        receiveLine = nil
        zconnection = nil
        disconnect = nil
        
        
        collectgarbage()   
        -- rt_connect()
    end    
    
    --zzz
    function zconnection(s)
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

