-- petit script pour la gestion du GET du serveur web

print("\n web_get.lua   hv180907.1557  \n")

webtimer1=tmr.create()
webtimer2=tmr.create()
webtimer3=tmr.create()
webtimer4=tmr.create()

function forward_stop()
        if zauto then 
            tmr.alarm(webtimer3, turn_on, tmr.ALARM_SINGLE, forward)
        else
            tmr.alarm(webtimer3, turn_on, tmr.ALARM_SINGLE, stop)
        end
end

--Réaction des boutons 
function web_get()
    if (_GET.pin == "L") then
        left()
        forward_stop()
    elseif (_GET.pin == "R") then
        right()
        forward_stop()
    elseif (_GET.pin == "F") then 
        forward()        
    elseif (_GET.pin == "B") then
        backward()       
    elseif (_GET.pin == "S") then
        zauto=false
        stop()        
    elseif (_GET.pin == "SL") then
        zpeed=50
        set_speed()
    elseif (_GET.pin == "SM") then
        zpeed=70
        set_speed()
    elseif (_GET.pin == "SF") then
       zpeed=100
       set_speed()
    elseif (_GET.pin == "A") then
        tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, function()
            stop()
            oled_line1="Auto..."   oled_line2=""   oled_line3=""   oled_line4=""   oled_line5=""
            disp_oled()
            zauto=true
            tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, start_mesure)
        end)
    elseif (_GET.pin == "ML") then
        tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, function()
            stop()
            oled_line1="Manuel..."   oled_line2=""   oled_line3=""   oled_line4=""   oled_line5=""
            disp_oled()
            zauto=false 
        end)
    elseif (_GET.pin == "T1") then
        tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, function()
            dofile("start_job.lua")
        end)
    elseif (_GET.pin == "T2") then
        oled_line1="Restart..."   oled_line2=""   oled_line3=""   oled_line4=""   oled_line5=""
        disp_oled()
        zauto=false
        tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, node.restart)
     elseif (_GET.pin == "T3") then
        tmr.alarm(webtimer1, 500, tmr.ALARM_SINGLE, function()
            zauto=false
            zmeter=true
            stop()
            oled_line1="Meter..."   oled_line2=""   oled_line3=""   oled_line4=""   oled_line5=""
            disp_oled()
            tmr.alarm(webtimer2, 600, tmr.ALARM_AUTO, start_mesure)
        end)
    end
end

