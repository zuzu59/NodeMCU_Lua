-- test de clearing de functions
print("\n clear_bootstrap.lua zf180720.1510   \n")

zRelay=nil

-- blink LED
if ztmr_LEDz then
    tmr.stop(ztmr_LEDz)
    tmr.unregister(ztmr_LEDz)
    ztmr_LEDz=nil
end
if zLEDz then
    gpio.mode(zLEDz, gpio.INPUT)
end
blink_LEDz=nil zLEDz=nil zFlag_LEDz=nil zTm_On_LEDz=nil zTm_Off_LEDz=nil

-- btn read
if ztmr_btnz then
    tmr.stop(ztmr_btnz)
    tmr.unregister(ztmr_btnz)
    ztmr_btnz=nil
end
if zBTNz then
gpio.trig(zBTNz, "none")
gpio.mode(zBTNz, gpio.INPUT)
zBTNz=nil
end
btn_clicz=nil btn_testz=nil t1z=nil t2z=nil t3z=nil

-- get ip
if ztmr_get_ipz then
    tmr.stop(ztmr_get_ipz)
    get_ipz=nil
end

-- dir files
dir=nil l=nil k=nil v=nil i=nil

