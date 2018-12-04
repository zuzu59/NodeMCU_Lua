-- Scripts effet guirlande de Noël pour le balcon
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n a_guirlande.lua zf181201.1146 \n")

znbled=300
zstep=3
zpower=0.8

function RGB_clear()
    ws2812.init()
    buffer = ws2812.newBuffer(znbled, 3)
    buffer:fill(0, 0, 0)
    ws2812.write(buffer)
end

RGB_clear()

for i=1, znbled, zstep do
    buffer:set(i, 123*zpower, 124*zpower, 125*zpower)
end
ws2812.write(buffer)

a={}
a=buffer:get(1)
print(buffer:get(1))
print(a)


a={}
a[0]=123
a[1]=124
a[2]=125

print(a[0],a[1],a[2])




