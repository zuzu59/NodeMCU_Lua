-- petit script pour la gestion du GET du serveur web

print("\n web_get.lua   zf181018.1142  \n")
 
function web_get()
    if (_GET.led == "on") then
        led_on()
    elseif (_GET.led == "off") then
        led_off()
    end
end

