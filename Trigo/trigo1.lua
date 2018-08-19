-- Essais de fire des fonctions trigos qui manque dans NodeMCU
-- ATTENTION: arcsin ne fonctionne pas pour les valeur proche de 1 !
-- source: https://www.esp8266.com/viewtopic.php?p=64415#
print("\ntrigo1.lua   zf180726.1136   \n")

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

function arcsin(x)
   local suma=x
   for i=1,60 do
      suma = suma + (dfi(2*i-1)/dfp(2*i))*(math.pow(x,2*i+1)/(2*i+1))
      print("Suma: "..suma)
   end
   return suma
end

function dfp(x)
   local par=1
   for i=2,x,2 do
      par = par * i
   end
   return par
end

function dfi(x)
   local impar=1
   for i=1,x,2 do
      impar = impar * i
   end
   return impar
end
