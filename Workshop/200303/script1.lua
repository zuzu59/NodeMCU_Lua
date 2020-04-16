a=0.5
b=3
print(a*b)
print(a+b)

c=a*b

print("la valeur de c est: ",c)

gpio.mode(0,gpio.OUTPUT)

if c>=3 then
    gpio.write(0,0)
else
    gpio.write(0,1)
end
