-- petit script pour la gestion du GET du serveur web

print("\n web_get.lua   zf181018.1649  \n")
 
function web_get()
    if (_GET.led == "on") then
        led_on()
        html_home()
    elseif (_GET.led == "off") then
        led_off()
        html_home()
    else
        html_home()
    end
end

