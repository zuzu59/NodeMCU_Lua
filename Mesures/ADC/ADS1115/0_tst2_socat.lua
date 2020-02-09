-- tests connection reverse telnet
-- commande à faire tourner sur le serveur
--[[
socat TCP-LISTEN:23002,fork,reuseaddr STDIO
socat TCP-LISTEN:23002,reuseaddr,fork TCP-LISTEN:24002,reuseaddr
]]

print("\n 0_tst2_socat.lua   zf200209.1442   \n")

srv_rt = net.createConnection(net.TCP, 0)
srv_rt:connect(console_port,console_host)
srv_rt:on("connection", function(sck)

    print("c'est connected...")

    function s_output(str) 
      if(sck~=nil) 
        then sck:send(str) 
      end 
    end 
    node.output(s_output, 0)   
    -- re-direct output to function s_ouput.
    sck:on("receive",function(c,l) 
      node.input(l)           
      --like pcall(loadstring(l)), support multiple separate lines
    end) 
    sck:on("disconnection",function(c) 
      node.output(nil)        
      print("c'est disconnected...")
      --unregist redirect output function, output goes to serial
    end) 
    print("Welcome to NodeMcu world.")
    


end)


--[[

print(srv:getpeer())

if console_port == srv:getpeer() then
    gpio.write(zLED, gpio.LOW)
else
    gpio.write(zLED, gpio.HIGH)
end



s=net.createServer(net.TCP,180) 
s:listen(2323,function(c) 
    function s_output(str) 
      if(c~=nil) 
        then c:send(str) 
      end 
    end 
    node.output(s_output, 0)   
    -- re-direct output to function s_ouput.
    c:on("receive",function(c,l) 
      node.input(l)           
      --like pcall(loadstring(l)), support multiple separate lines
    end) 
    c:on("disconnection",function(c) 
      node.output(nil)        
      --unregist redirect output function, output goes to serial
    end) 
    print("Welcome to NodeMcu world.")
end)
]]



