-- Affiche simplement quelque chose sur le mini display OLED du nodeMCU mini D1
-- Source: https://wiki.wemos.cc/products:d1_mini_shields:oled_shield
-- font_10x20,font_6x10,font_7x13,font_8x13,font_9x15,font_chikita
print("\noled_first_minid1.lua   zf20180724.2232   \n")

pin_scl = 1
pin_sda = 2 
disp_sla = 0x3c

function init_OLED(sda, scl) --Set up the u8glib lib     
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_64x48_i2c(disp_sla)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     
end

function draw()
-- https://github.com/olikraus/u8glib/wiki/fontsize
-- font_10x20,font_6x10,font_7x13,font_8x13,font_9x15,font_chikita
    disp:setFont(u8g.font_10x20)
    disp:setFontPosTop()
    disp:drawStr(0,15,disp_text)
--[[
    disp:setFont(u8g.font_6x10)
    disp:setFontPosTop()
    disp:drawStr(0,0,"Hauteur de")
    disp:drawStr(0,10,"la cuve:")
    disp:drawStr(0,20,"185cm")
    disp:drawStr(0,30,"Capacit"..string.char(233)..":")
    disp:drawStr(0,40,"3'840l")
]]
end

function disp_page()
    print("coucou."..disp_text..".")
    disp:firstPage()
    repeat
        draw()
    until disp:nextPage() == false
end


disp_text="3'247W"
init_OLED(pin_sda, pin_scl) --Run setting up
disp_page()


--[[ source OLED: 
https://www.google.ch/search?q=nodemcu+lua+oled+display&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjG8ba8ra3cAhVDCpoKHedlDS4Q_AUICigB&biw=1536&bih=828
https://www.hackster.io/kayakpete/esp8266-oled-display-52ae50
http://blog.rl.cx/2017/01/08/bien-d%C3%A9buter-avec-nodemcu/
https://github.com/FredThx/nodemcu_iot/blob/master/i2c_display.lua
https://www.instructables.com/id/NODEMCU-LUA-ESP8266-With-I2C-LCD-128-X-64-OLED-Dis/
]]
