-- tests connection reverse telnet
-- commande à faire tourner sur le serveur
--[[
socat TCP-LISTEN:23002,fork,reuseaddr STDIO
socat TCP-LISTEN:23002,reuseaddr,fork TCP-LISTEN:24002,reuseaddr
]]

print("\n 0_tst2_socat.lua   zf200209.1615   \n")

srv_rt = net.createConnection(net.TCP, 0)

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


tmr_socat1=tmr.create()
tmr_socat1:alarm(1*1000, tmr.ALARM_AUTO , function()

    gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)
    if console_port == srv_rt:getpeer() then
        gpio.write(zLED, gpio.LOW)
    else
        gpio.write(zLED, gpio.HIGH)
        print("trying...")
        srv_rt:connect(console_port,console_host)
    end


end)


--[[

print(srv_rt:getpeer())

srv_rt:connect(console_port,console_host)

gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)
if console_port == srv_rt:getpeer() then
    gpio.write(zLED, gpio.LOW)
else
    gpio.write(zLED, gpio.HIGH)
end


]]



