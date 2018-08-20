-- 3e Essais de faire des fonctions trigos qui manquent dans NodeMCU
-- source pour arctan,arcsin et arccos: http://mathonweb.com/help_ebook/html/algorithms.htm
-- source pour sin&cos: https://www.esp8266.com/viewtopic.php?p=64415#
-- source pour arcsin&arctan: http://www.electronicwings.com/nodemcu/magnetometer-hmc5883l-interfacing-with-nodemcu

print("\ntrigo3.lua   zf180820.2205   \n")

Gros problème encore avec les atan négatives et du coup avec les acos, zf180820.2252


function zsin(x)
    local y=1
    if x>math.pi*2 then   x=x%(math.pi*2)   end
    if x>math.pi then   y=-1   x=x-math.pi   end
    if x>math.pi/2 then   x=math.pi-x   end
    local p=x   local f=1   local r=p
    for j=2,10,2 do   p=-p * x * x   f=f*j*(j+1)   r=r+p/f   end
   return(y*r)
end

function zcos(x)
   if x>math.pi*2 then   x=x%(math.pi*2)   end
   if x>math.pi then   x=math.pi-x   end
   return zsin(math.pi/2-x)
end

function ztan(x)
   return zsin(x)/zcos(x)
end

function zasin(x)
   return zatan(x/math.sqrt(1-x*x))
end

function zacos(x)
   return zatan(math.sqrt(1-x*x)/x)
end





function zatan(x)
  local y=1  local z
  if x<0 then   y=-1  x=y*x   end
  if x<1 then   z=zzatan(x)   else   z=math.pi/2-zatan(1/x)   end
  return y*z
end

function zzatan(x)
  return x-x^3/3+x^5/5-x^7/7
end





--[[
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
]]
