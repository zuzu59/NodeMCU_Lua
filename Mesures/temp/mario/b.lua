-- Scripts pour tester du code lua
--[[

Commandes à envoyer via un terminal:
~.
./luatool.py --ip $zIP:$zport -f b.lua
telnet -rN $zIP $zport
dofile("b.lua")
]]

print("\n b.lua zf191203.2206 \n")

print(3*4)
a=44
b=555
print(a*b)
print(a+b)
print("toto")
