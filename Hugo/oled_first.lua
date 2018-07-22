--Affiche simplement un Hello Wolrd sur le display OLED
print("\nDémarrage hv20180720.1616   \n")





--  Utilisation :
--              pin_sda = 5 
--              pin_scl = 6 
--              disp_sla = 0x3c
--              _dofile("i2c_display")
--              disp_add_data(texte)
--          avec texte un json du type
--          texte = '{ "id": "id_du_texte",
--                     "column": [0-20],    (si omis : 0)
--                     "row": [0-5],        (si omis : 0)
--                     "text": "abcdef",      (si omis : "")
--                     "angle": [0,90,180,270] }'     (si omis 0°)
--
--          disp_add_data('{"id":"id_du_texte"}') efface le texte
-------------------------------------------------
-- Modules nécessaires dans le firmware :
--    i2c, u8g(avec font ssd1306_128x64_i2c), cjson
-------------------------------------------------

pin_sda = 12 
pin_scl = 11 
disp_sla = 0x3c


function init_OLED(sda, scl) --Set up the u8glib lib
     
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(disp_sla)
-- https://github.com/olikraus/u8glib/wiki/fontsize
     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
end

function draw()
    disp:drawStr(0,0,"Hello Hugo !")
    disp:drawStr(0,11,"et zuzu !")
end

init_OLED(pin_sda, pin_scl) --Run setting up

disp:firstPage()
repeat
    draw()
until disp:nextPage() == false









--print( string.gsub("hello+zuzu+%26+une+belle+%E9cole%5Cun+b%E2teau","+"," ")

--[[ source OLED: 
https://www.google.ch/search?q=nodemcu+lua+oled+display&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjG8ba8ra3cAhVDCpoKHedlDS4Q_AUICigB&biw=1536&bih=828
https://www.hackster.io/kayakpete/esp8266-oled-display-52ae50
http://blog.rl.cx/2017/01/08/bien-d%C3%A9buter-avec-nodemcu/
https://github.com/FredThx/nodemcu_iot/blob/master/i2c_display.lua
https://www.instructables.com/id/NODEMCU-LUA-ESP8266-With-I2C-LCD-128-X-64-OLED-Dis/
]]
