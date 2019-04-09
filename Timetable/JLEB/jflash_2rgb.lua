-- Scripts juste pour flasher deux LED's sur un ruban RGB
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n jflash_2rgb.lua jv190408.1815 \n")

dofile("jled_rgb.lua")

zLED1=1   zLED2=6
nbfois1 = 0   nbfois2 = 0
zLED_state1 = 0   zLED_state2 = 0

R1 = 255   G1 = 0   B1 = 0
R2 = 0   G2 = 255   B2 = 0

zTm_On_LED = 200   zTm_Off_LED = 400   zTm_Pause = 2000    --> en ms

ztmr_Flash_LED1 = tmr.create()   ztmr_Flash_LED2 = tmr.create()

function flash_LED1 ()
    if nbfois1 >= xfois1 then
        print("nbfois1: "..nbfois1)
        nbfois1 = 0
        jled_rgb(zLED1,R1,G1,B1,0)
        tmr.alarm(ztmr_Flash_LED1, zTm_Pause, tmr.ALARM_SINGLE, flash_LED1)
    else 
        if zLED_state1 == 0 then
            jled_rgb(zLED1,R1,G1,B1,1)
            zLED_state1 = 1
            tmr.alarm(ztmr_Flash_LED1, zTm_On_LED, tmr.ALARM_SINGLE, flash_LED1)
            nbfois1 = nbfois1 + 1
        else 
            jled_rgb(zLED1,R1,G1,B1,0)
            zLED_state1 = 0
            tmr.alarm(ztmr_Flash_LED1, zTm_Off_LED, tmr.ALARM_SINGLE, flash_LED1)
        end
    end
end

function flash_LED2 ()
    if nbfois2 >= xfois2 then
        print("nbfois2: "..nbfois2)
        nbfois2 = 0
        jled_rgb(zLED2,R2,G2,B2,0)
        tmr.alarm(ztmr_Flash_LED2, zTm_Pause, tmr.ALARM_SINGLE, flash_LED2)
    else 
        if zLED_state2 == 0 then
            jled_rgb(zLED2,R2,G2,B2,1)
            zLED_state2 = 1
            tmr.alarm(ztmr_Flash_LED2, zTm_On_LED, tmr.ALARM_SINGLE, flash_LED2)
            nbfois2 = nbfois2 + 1
        else 
            jled_rgb(zLED2,R2,G2,B2,0)
            zLED_state2 = 0
            tmr.alarm(ztmr_Flash_LED2, zTm_Off_LED, tmr.ALARM_SINGLE, flash_LED2)
        end
    end
end

xfois1 = 5
flash_LED1 ()
xfois2 = 2
flash_LED2 ()


--[[

]]

