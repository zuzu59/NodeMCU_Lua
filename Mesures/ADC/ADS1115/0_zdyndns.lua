-- Petit script pour s'inregistrer sur zdyndns

function send_zdyndns()
    if verbose then print("\n 0_zdyndns.lua   zf200216.1822   \n") end

    zip = wifi.sta.getip()
    zdyndns_str = "s "..node_id..","..console_host..":"..tostring(console_port).." "..zip
    if verbose then print("zdyndns_str: "..zdyndns_str) end

    srv_zdyndns = net.createConnection(net.TCP, 0)
    srv_zdyndns:on("connection", function(sck)
        print("connected...")
        print("sending...")

        sck:send(zdyndns_str, function(sk)
          sk:close()
          print("close...")
        end)

        print("je ne sais pas quoi afire ici")

    end)

    srv_zdyndns:connect(console_port,console_host)

    zdyndns_str=nil zip=nil send_zdyndns=nil
    if verbose then print(node.heap()) end
    collectgarbage()
    if verbose then print(node.heap()) end
end

send_zdyndns()
