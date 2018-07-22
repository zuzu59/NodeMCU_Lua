-- start.lua
-- programme de start
-- zf180719.1057

do

local zLED=0
local zTm_On_LED = 100    --> en ms
local zTm_Off_LED = 900    --> en ms
local zFlag_LED = 0

local function blink_LED ()
    local ztmr_LED = tmr.create()
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
blink_LED ()

end
