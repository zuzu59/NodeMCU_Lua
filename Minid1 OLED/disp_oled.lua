-- Affiche plusieurs lignes sur le mini display OLED du MiniD1
-- Source: https://wiki.wemos.cc/products:d1_mini_shields:oled_shield
-- font_10x20,font_6x10,font_7x13,font_8x13,font_9x15,font_chikita
print("\n disp_oled.lua   zf180824.2351   \n")

-- config pour le mini display OLED du Wemos Mini_D1
pin_scl = 1
pin_sda = 2 
disp_sla = 0x3c


function init_OLED(sda, scl) --Set up the u8glib lib     
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_64x48_i2c(disp_sla)
-- https://github.com/olikraus/u8glib/wiki/fontsize
     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
end

function draw()
-- font_10x20,font_6x10,font_7x13,font_8x13,font_9x15,font_chikita
    disp:setFont(u8g.font_6x10)
    disp:drawStr(0,0,oled_line1)
    disp:drawStr(0,10,oled_line2)
    disp:drawStr(0,20,oled_line3)
    disp:drawStr(0,30,oled_line4)    --..string.char(233))  -- affiche un é !
    disp:drawStr(0,40,oled_line5)

--    disp:setFont(u8g.font_9x15)
--    disp:drawStr(0,0,"1'200W")



--    disp:drawStr(0,11,"et zuzu !")
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
