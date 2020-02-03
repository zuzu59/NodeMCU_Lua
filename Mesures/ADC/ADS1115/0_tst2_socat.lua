-- tests connection reverse telnet
-- commande à faire tourner sur le serveur
-- socat TCP-LISTEN:4444,fork,reuseaddr STDIO

print("\n 0_tst2_socat.lua   zf200203.1734   \n")


srv = net.createConnection(net.TCP, 0)

srv:connect(4444,"192.168.0.184")

srv:on("connection", function(sck)

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
      --unregist redirect output function, output goes to serial
    end) 
    print("Welcome to NodeMcu world.")
    


end)


--[[
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



