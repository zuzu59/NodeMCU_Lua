-- Petit script pour s'inregistrer sur zdyndns

function send_zdyndns()
    if verbose then print("\n 0_zdyndns.lua   zf200220.0944   \n") end

    zip = wifi.sta.getip()
    zdyndns_str = "s "..node_id..","..console_host..":"..tostring(console_port+yellow_tag).." "..zip
    if verbose then print("zdyndns_str: "..zdyndns_str) end


    srv_zdyndns = net.createConnection(net.TCP, 0)

    srv_zdyndns:on("receive", function(conn, pl)
        print("receiving...")
        print(pl) 
    end)

    srv_zdyndns:on("connection", function(sck)
        print("connected...")
        print("sending...")
        sck:send(zdyndns_str, function(sk)
          sk:close()
          print("close...")
        end)
    end)
    
    srv_zdyndns:connect(zdyndns_port,zdyndns_host)



    zdyndns_str=nil zip=nil send_zdyndns=nil
    if verbose then print(node.heap()) end
    collectgarbage()
    if verbose then print(node.heap()) end
end

send_zdyndns()
