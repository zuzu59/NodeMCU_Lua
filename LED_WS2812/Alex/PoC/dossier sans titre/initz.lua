
print()
print("starting init.lua...")
print()
print("local files:")
l=file.list()
for k,v in pairs(l) do
   print(k.." "..v)
end
print()

print("starting webleds...")
print()
dofile('webleds.lua')

