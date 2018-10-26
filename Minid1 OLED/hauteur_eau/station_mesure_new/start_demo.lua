-- Permet de démarrer une petite démo simplement via telnet
print("\n start_demo1.lua   zf181024.1922   \n")

dofile("disp_oled.lua")

oled_line1="DEMO"
oled_line2=""
oled_line3=""
oled_line4=""
oled_line5=""
disp_oled()

function disp_mesure ()
    print(zlength)    
    oled_line1=zlength.." m"
    oled_line2=""
    oled_line3=""
    oled_line4=""
    oled_line5="181024.1922"
    disp_oled()
--    disp_send()
end

--dofile("web_cli.lua")

dofile("ultra_son.lua")
tmr.alarm(detectortimer1, 1000, tmr.ALARM_AUTO, zmesure_pulse)

