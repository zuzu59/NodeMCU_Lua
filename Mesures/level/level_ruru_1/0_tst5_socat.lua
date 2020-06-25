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

print("\n 0_tst5_socat.lua   zf200625.1204   \n")

function rt_connect()
    -- print("................rt_connect")
    collectgarbage()
    local zlaps=tmr.now()/1000000-ztime_connect
    -- print("time of retry connect... "..zlaps)
    -- if debug_rec~=nil then  debug_rec("time of retry connect... "..zlaps..", "..node.heap())   end
    if zlaps>1 then
        local zstr="trying connect to "..console_host..":"..console_port..", "..node.heap()
        -- if debug_rec~=nil then  debug_rec(zstr)   end
        if verbose==verbose then
            gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH)
            -- print(zstr)   
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
            print("connected on "..console_host..":"..console_port..", "..node.heap())
            print(node.heap())
            --        end
            if http_post~=nil then  http_post(influxdb_url,"energy,memory=socat_connected_"..yellow_id.." ram="..node.heap())  end
            dofile("0_rtelnet1.lua")
            telnet_listener(sck)
            print("Welcome to NodeMCU world.")
        end)
        
        srv_rt:on("reconnection", function(sck)
            -- print(";;;;;;;;;;;;;;;;reconnection")
            srv_rt:on("connection", nil)
            srv_rt:on("reconnection", nil)
        end)
        
        -- srv_rt:on("disconnection", function(sck)
        --     print(";;;;;;;;;;;;;;;;disconnection")
        -- end)
        -- 
        -- srv_rt:on("receive", function(sck)
        --     print(";;;;;;;;;;;;;;;;receive")
        -- end)
        -- 
        -- srv_rt:on("sent", function(sck)
        --     print(";;;;;;;;;;;;;;;;sent")
        -- end)
        
        
        srv_rt:connect(console_port,console_host)
    else
        print("on ne se reconnecte pas vite 1x...")
    end
    collectgarbage()    
end




function rt_launch()
    -- if http_post~=nil then  http_post(influxdb_url,"energy,memory=tmr_socat1_"..yellow_id.." ram="..node.heap())  end
    if srv_rt~=nil then
        -- if http_post~=nil then  http_post(influxdb_url,"energy,memory=srv_rt_no_nil_"..yellow_id.." ram="..node.heap())  end        
        if console_port ~= srv_rt:getpeer() then
            rt_connect()
        end
    else
        rt_connect()
    end
end


tmr_socat1=tmr.create()
tmr_socat1:alarm(10*1000, tmr.ALARM_AUTO , rt_launch)


ztime_connect=tmr.now()/1000000-10

rt_launch()

print("Revers telnet server running...\n")
