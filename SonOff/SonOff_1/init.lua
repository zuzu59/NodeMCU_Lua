-- init.lua
-- test si clic sur le bouton
-- clic <2s goto start.lua
-- clic >2s goto config wifi
print("\ninit.lua zf180717.1125 \n")

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
--pwm.setup(zLED, 1, 500)
--pwm.start(zLED)
zTm_On_LED = 500    --> en ms
zTm_Off_LED = 500    --> en ms
blink_LED ()

function btn_test()
    print("test")
    t2=tmr.now()
    t3=(t2-t1)/1000000
    print("t3: "..t3)
    if gpio.read(zBTN)==1 then
        tmr.stop(0)
        gpio.trig(zBTN)
        --pwm.stop(zLED)
        tmr.stop(ztmr_LED)
        gpio.write(zLED,1)
        print("start.lua")
        dofile("start.lua")
    end
    if t3>2 then
        tmr.stop(0)
        gpio.trig(zBTN)       
        --pwm.setup(zLED, 10, 500)
        --pwm.start(zLED)
        zTm_On_LED = 100    --> en ms
        zTm_Off_LED = 100    --> en ms
        blink_LED ()
        wifi.sta.disconnect()
        wifi.sta.clearconfig()
        print("\nwifi config http://192.168.4.1\n")
        tmr.alarm(0, 1000, tmr.ALARM_AUTO , get_ip)
        enduser_setup.start()
    end
end

function btn_clic()
    print("clic")
    t1=tmr.now()
    --pwm.stop(zLED)
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
        tmr.alarm(0,3000,tmr.ALARM_SINGLE, function() node.restart() end)
    end
end

function dir()
    l=file.list()
    for k,v in pairs(l) do
    print(k.." "..v)
    end
    print('\nusage: dofile("file.lua")\n')
end


gpio.mode(zBTN,gpio.INT)
gpio.trig(zBTN, "down", btn_clic)

wifi.sta.connect()
dofile("telnet_srv.lua")

