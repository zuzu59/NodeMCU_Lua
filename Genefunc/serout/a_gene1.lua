-- Générerateur de fonction signal carré de fréquence variable

print("\n a_gene1.lua zf190401.2302 \n")

pin_gene = 5
gpio.mode(pin_gene,gpio.OUTPUT)
gpio.write(pin_gene,gpio.LOW)

function genepulse(zpulse)
    print("tutu")
    gpio.serout(pin_gene,gpio.HIGH,{zpulse,zpulse},1000000,genesquare)
end

function genesquare()
    print("toto")
    zdemieperiode=1/zfreq*1000000/2
    print("Demie période: ",zdemieperiode)
    genepulse(zdemieperiode)    
    print("titi")
end

zfreq=5000*(10/9.43)
genesquare()

--[[
genesquare(0)
]]
