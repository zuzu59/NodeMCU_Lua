-- tests des routines trigonométriques pour NodeMCU
print("\ntest_trigo1.lua   zf180820.2209   \n")

-- chargement des routines trigonométriques
dofile("trigo3.lua")

for i = 0, 2*math.pi, 2*math.pi/32 do
  a=i
--  b=math.tan(a)
--  print("arctangente: "..a..", "..b..", "..math.atan(b)..", "..zatan(b)..", "..math.atan(b)/zatan(b))
--  print("sinus: "..a..", "..math.sin(a)..", "..zsin(a)..", "..math.sin(a)/zsin(a))
--  print("cosinus: "..a..", "..math.cos(a)..", "..zcos(a)..", "..math.cos(a)/zcos(a))
--  print("tangente: "..a..", "..math.tan(a)..", "..ztan(a)..", "..math.tan(a)/ztan(a))
--  b=math.sin(a)
--  print("arcsinus: "..a..", "..b..", "..math.asin(b)..", "..zasin(b)..", "..math.asin(b)/zasin(b))
  b=math.cos(a)
  print("arccosinus: "..a..", "..b..", "..math.acos(b)..", "..zacos(b)..", "..math.acos(b)/zacos(b))
end

print("\n")
x=-0.70710678118655
print(math.acos(x))
print(zatan(math.sqrt(1-x*x)/x))
print(math.sqrt(1-x*x)/x)
