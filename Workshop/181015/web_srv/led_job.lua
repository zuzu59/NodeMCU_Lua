--Petit script pour la gestion de la LED, juste pour comprendre la prog ;-)

print("\n led_job.lua   zf181018.1104   \n")

zLED=0
gpio.mode(zLED, gpio.OUTPUT)
gpio.write(zLED, gpio.HIGH)

function led_on()
    gpio.write(zLED, gpio.LOW)
    fled="ON"
end

function led_off()
    gpio.write(zLED, gpio.HIGH)
    fled="ON"
end

led_on()
led_off()



    local _on, _off = "", ""
    if (_GET.pin == "ON") then
      _on = " selected=\"true\""
      gpio.write(zLED, gpio.LOW)
    elseif (_GET.pin == "OFF") then
      _off = " selected=\"true\""
      gpio.write(zLED, gpio.HIGH)
    end
    buf = buf .. "<option" .. _off .. ">OFF</option><option" .. _on .. ">ON</option></select></form></body></html>"
