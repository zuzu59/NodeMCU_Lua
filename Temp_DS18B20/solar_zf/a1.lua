-- programme pour faire un test depuis de le webide

-- source: https://nodemcu.readthedocs.io/en/master/modules/ds18b20/

function a1()
    print("\n a1.lua zf190601.1538 \n")
end

a1()

local ow_pin = 4
ds18b20.setup(ow_pin)

print("toto182538")

-- read all sensors and print all measurement results
ds18b20.read(
    function(ind,rom,res,temp,tdec,par)
        print(ind,string.format("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X",string.match(rom,"(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)")),res,temp,tdec,par)
    end,{})

print("tutu152603")

