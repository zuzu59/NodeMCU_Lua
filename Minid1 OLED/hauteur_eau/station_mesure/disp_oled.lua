-- Affiche plusieurs lignes sur le mini display OLED du MiniD1
-- Source: https://wiki.wemos.cc/products:d1_mini_shields:oled_shield
-- font_10x20,font_6x10,font_7x13,font_8x13,font_9x15,font_chikita
print("\n disp_oled.lua   zf180826.1807   \n")

-- config pour le mini display OLED du Wemos Mini_D1
pin_scl = 1
pin_sda = 2 
disp_sla = 0x3c

function init_OLED(sda, scl)     
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_64x48_i2c(disp_sla)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
end

-- font_10x20,font_6x10,font_7x13,font_8x13,font_9x15,font_chikita
--..string.char(233)..":")  -- pour afficher un é !
function draw()
    disp:setFont(u8g.font_10x20)
    disp:setFontPosTop()
    disp:drawStr(0,00,oled_line1)
    disp:setFont(u8g.font_chikita)
    disp:setFontPosTop()
    disp:drawStr(0,17,oled_line2)
    disp:drawStr(0,24,oled_line3)
    disp:drawStr(0,31,oled_line4)
    disp:drawStr(0,38,oled_line5)
end

function disp_oled()
    disp:firstPage()
    repeat
        draw()
    until disp:nextPage() == false
end

init_OLED(pin_sda, pin_scl)
