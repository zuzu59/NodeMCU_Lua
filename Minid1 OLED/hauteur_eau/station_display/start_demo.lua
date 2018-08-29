-- Permet de démarrer une petite démo simplement via telnet
print("\n start_demo1.lua   zf180828.1816   \n")

--dofile("disp_oled.lua")

oled_line1="DEMO"
oled_line2="hauteur cuve:"
oled_line3="2.57 m"
oled_line4=""
oled_line5=wifi.ap.getip()
disp_oled()

