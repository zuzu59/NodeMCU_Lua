-- 2e Essais de faire des fonctions trigos qui manque dans NodeMCU
-- source pour sin&cos: https://www.esp8266.com/viewtopic.php?p=64415#
-- source pour arcsin&arctan: http://www.electronicwings.com/nodemcu/magnetometer-hmc5883l-interfacing-with-nodemcu
print("\ntrigo2.lua   zf180726.1149   \n")



function sin(x)
   local p=-x*x*x
   local f=6
   local r=x+p/f
   for j=1,60 do
      p=-p*x*x
      f=f*2*(j+1)*(j+j+3)
      r=r+p/f
   end
   return r
end

function cos(x)
   return sin(math.pi/2-x)
end

function tan(x)
   return sin(x)/cos(x)
end




pi = 3.14159265358979323846


function arcsin(value)
    local val = value
    local sum = value 
    if(value == nil) then
        return 0
    end
-- as per equation it needs infinite iterations to reach upto 100% accuracy
-- but due to technical limitations we are using
-- only 10000 iterations to acquire reliable accuracy
    for i = 1,10000, 2 do
        val = (val*(value*value)*(i*i)) / ((i+1)*(i+2))
        sum = sum + val;
    end
    return sum
end

function arctan(value)
    if(value == nil) then
        return 0
    end
    local _value = value/math.sqrt((value*value)+1)
    return arcsin(_value)
end

function atan2(y, x)
    if(x == nil or y == nil) then
        return 0
    end

    if(x > 0) then
        return arctan(y/x)
    end
    if(x < 0 and 0 <= y) then
        return arctan(y/x) + pi
    end
    if(x < 0 and y < 0) then
        return arctan(y/x) - pi
    end
    if(x == 0 and y > 0) then
        return pi/2
    end
    if(x == 0 and y < 0) then
        return -pi/2
    end
    if(x == 0 and y == 0) then
        return 0
    end
    return 0
end

print("On voit que l'arc sinus est précis au 1/2% prêt !")
print("sin(3.14/2): "..sin(3.14/2))
print("pi/(arcsin(1)*2): "..pi/(arcsin(1)*2))




