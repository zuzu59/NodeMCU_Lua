-- petit script pour la gestion du GET du serveur web

print("\n web_get.lua   zf181019.1130  \n")
 
function web_get()
    if (_GET.led == "on") then
        led_on()
        html_home()
    elseif (_GET.led == "off") then
        led_off()
        html_home()
    elseif (_GET.led == "flash") then
        xfois=tonumber(_GET.fois)
        blink_LED()
        html_home()
    elseif (_GET.led == "status") then
        html_status()
    else
        html_home()
    end
end

