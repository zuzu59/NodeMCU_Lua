-- Lit le le petit convertisseur ADC ADS1115

-- Malheureusement cette méthode est très lente, 
-- on ne peut pas lire plus vite que 1.6mS !
-- et encore sur le même canal

function readADS1115()
    if verbose then print("\n 0_ads1115.lua   zf200126.1803 \n") end
    
    id = 0   sda = 5   scl = 6   addr = 0x48
    
    i2c.setup(id, sda, scl, i2c.FAST)   sda = nil   scl = nil
    ads1115.reset()
    adc = ads1115.ads1115(id, addr)

    t1=tmr.now()
    adc:setting(ads1115.GAIN_6_144V, ads1115.DR_860SPS, ads1115.SINGLE_0, ads1115.CONTINUOUS)
    t2=tmr.now()
    print("setup, t2-t1: ",(t2-t1)/1000)

    tmr.delay(10*1000)

    function read_ADS1115()
        t1=tmr.now()
        volt = adc:read()
        t2=tmr.now()
        print("read, t2-t1: ",(t2-t1)/1000)
        print(volt) 
    end

--[[
if verbose then print("ADC0: "..read_ADS1115(0).." V") end

    id=nil sda=nil scl=nil addr=nil HUMIDITY=nil TEMPERATURE=nil r=nil
    read_HTU21D=nil readTemp=nil readHumi=nil readHTU21D=nil
]]
    if verbose then print(node.heap()) end
    collectgarbage()
    if verbose then print(node.heap()) end
end

verbose=true
readADS1115()
read_ADS1115()

--[[
read_ADS1115(0)

]]
