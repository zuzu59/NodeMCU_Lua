-- tests des routines trigonométriques pour NodeMCU
print("\ntest_trigo1.lua   zf1808201.1758   \n")

-- chargement des routines trigonométriques
dofile("trigo3.lua")

for i = 0, 4*math.pi, 4*math.pi/64 do
  a=i
  b=math.tan(a)
  print("arctangente: "..a..", "..b..", "..math.atan(b)..", "..zatan(b)..", "..math.atan(b)/zatan(b))

--  print("sinus: "..a..", "..math.sin(a)..", "..zsin(a)..", "..math.sin(a)/zsin(a))
--  print("cosinus: "..a..", "..math.cos(a)..", "..zcos(a)..", "..math.cos(a)/zcos(a))
--  print("tangente: "..a..", "..math.tan(a)..", "..ztan(a)..", "..math.tan(a)/ztan(a))
  b=math.sin(a)
--  print("arcsinus: "..a..", "..b..", "..math.asin(b)..", "..zasin(b)..", "..math.asin(b)/zasin(b))

  b=math.cos(a)
--  print("arccosinus: "..a..", "..b..", "..math.acos(b)..", "..zacos(b)..", "..math.acos(b)/zacos(b))

end

print("\n")
y=2.5525440310417
print("y: "..y)
x=math.cos(y)
print("x: "..x)
print("math.acos: "..math.acos(x))
z=math.sqrt(1-x*x)/x
print("z: "..z)
print("zatan: "..zatan(z))

















--
