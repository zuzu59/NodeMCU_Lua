-- tests des routines trigonométriques pour NodeMCU
print("\ntest_trigo1.lua   zf180819.1731   \n")

-- chargement des routines trigonométriques
dofile("trigo3.lua")

for i = 0, 2*pi, 2*pi/100 do
  a=i
  --print("tangente: "..a..", "..math.tan(a)..", "..ztan(a))
  b=math.tan(a)
  print("arctangente: "..b..", "..math.atan(b)..", "..zatan(b)..", "..math.atan(b)/zatan(b))
end
