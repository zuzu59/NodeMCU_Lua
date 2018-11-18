-- initz.lua
-- test si clic sur le bouton
-- clic <2s goto start.lua
-- clic >2s goto config wifi
print("\ninit.lua zf180719.1045    \n")

zBTN  = 3 -- GPIO0 button
--zRelay = 6 -- GPIO12 PWM0 relay (active high)
zLED = 0 -- SonOff: 7 GPIO13 PWM1, NodeMCU: 0, (active low)
zFlag_LED = 0

function blink_LED ()
    if zFlag_LED==gpio.LOW then 
        zFlag_LED=gpio.HIGH
        tmr.alarm(ztmr_LED, zTm_Off_LED, tmr.ALARM_SINGLE, blink_LED)
    else 
        zFlag_LED=gpio.LOW
        tmr.alarm(ztmr_LED, zTm_On_LED, tmr.ALARM_SINGLE, blink_LED)
    end
    gpio.write(zLED, zFlag_LED)
end

gpio.mode(zLED, gpio.OUTPUT)
ztmr_LED = tmr.create()
zTm_On_LED = 500
zTm_Off_LED = 500
blink_LED ()

function btn_test()
    t2=tmr.now()
    t3=(t2-t1)/1000000
    if gpio.read(zBTN)==1 then
        tmr.stop(0)
        gpio.trig(zBTN)
        tmr.stop(ztmr_LED)
        gpio.write(zLED,1)
        print("start.lua")

        ztmr_clear_bootstrap = tmr.create()
        tmr.alarm(ztmr_clear_bootstrap,1000,tmr.ALARM_SINGLE, function() dofile("clear_bootstrap.lua") end)

        
        
        dofile("start.lua")
    end
    if t3>2 then
        tmr.stop(0)
        gpio.trig(zBTN)       
        zTm_On_LED = 100
        zTm_Off_LED = 100
        blink_LED ()
        wifi.sta.disconnect()
        wifi.sta.clearconfig()
        print("\nwifi config http://192.168.4.1\n")
        tmr.alarm(0, 1000, tmr.ALARM_AUTO , get_ip)
        enduser_setup.start()
    end
end

function btn_clic()
    t1=tmr.now()
    tmr.stop(ztmr_LED)
    gpio.write(zLED,0)
    tmr.alarm(0,100,tmr.ALARM_AUTO, btn_test)
end

function get_ip()
    if wifi.sta.getip() == nil then
        print("Connecting to AP...")
    else
        tmr.stop(0)
        print("Connected! IP: ",wifi.sta.getip())
        tmr.alarm(0,4000,tmr.ALARM_SINGLE, function() node.restart() end)
    end
end

function dir()
    l=file.list() i=0
    for k,v in pairs(l) do
        i=i+v print(k..string.rep(" ",19-string.len(k)).." : "..v.." bytes")
    end
    print('\nUsed: '..i..' bytes\nusage: dofile("file.lua")\n')
end

gpio.mode(zBTN,gpio.INT)
gpio.trig(zBTN, "down", btn_clic)

wifi.sta.connect()
dofile("telnet_srv.lua")

