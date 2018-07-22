-- initz.lua
-- test si clic sur le bouton
-- clic <2s goto start.lua
-- clic >2s goto config wifi
print("\ninit.lua zf180719.1100    \n")

zBTNz  = 3 -- GPIO0 button
--zRelay = 6 -- GPIO12 PWM0 relay (active high)
zLEDz = 0 -- SonOff: 7 GPIO13 PWM1, NodeMCU: 0, (active low)
zFlag_LEDz = 0

function blink_LEDz ()
    if zFlag_LEDz==gpio.LOW then 
        zFlag_LEDz=gpio.HIGH
        tmr.alarm(ztmr_LEDz, zTm_Off_LEDz, tmr.ALARM_SINGLE, blink_LEDz)
    else 
        zFlag_LEDz=gpio.LOW
        tmr.alarm(ztmr_LEDz, zTm_On_LEDz, tmr.ALARM_SINGLE, blink_LEDz)
    end
    gpio.write(zLEDz, zFlag_LEDz)
end

gpio.mode(zLEDz, gpio.OUTPUT)
ztmr_LEDz = tmr.create()
zTm_On_LEDz = 500
zTm_Off_LEDz = 500
blink_LEDz ()

function btn_testz()
    t2z=tmr.now()
    t3z=(t2z-t1z)/1000000
    if gpio.read(zBTNz)==1 then
        tmr.stop(0)
        gpio.trig(zBTNz)
        tmr.stop(ztmr_LEDz)
        gpio.write(zLEDz,1)
        print("start.lua")

        ztmr_clear_bootstrapz = tmr.create()
--        tmr.alarm(ztmr_clear_bootstrapz,1000,tmr.ALARM_SINGLE, function() dofile("clear_bootstrap.lua") end)

        
        
        dofile("start.lua")
    end
    if t3z>2 then
        tmr.stop(0)
        gpio.trig(zBTNz)       
        zTm_On_LEDz = 100
        zTm_Off_LEDz = 100
        blink_LEDz ()
        wifi.sta.disconnect()
        wifi.sta.clearconfig()
        print("\nwifi config http://192.168.4.1\n")
        tmr.alarm(0, 1000, tmr.ALARM_AUTO , get_ipz)
        enduser_setup.start()
    end
end

function btn_clicz()
    t1z=tmr.now()
    tmr.stop(ztmr_LEDz)
    gpio.write(zLEDz,0)
    tmr.alarm(0,100,tmr.ALARM_AUTO, btn_testz)
end

function get_ipz()
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

gpio.mode(zBTNz,gpio.INT)
gpio.trig(zBTNz, "down", btn_clicz)

wifi.sta.connect()
dofile("telnet_srv.lua")

