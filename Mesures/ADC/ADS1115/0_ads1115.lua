-- Lit le le petit convertisseur ADC ADS1115

function readADS1115()
    if verbose then print("\n 0_ads1115.lua   zf200126.1741 \n") end
    
    id = 0   sda = 5   scl = 6   addr = 0x48
    
    i2c.setup(id, sda, scl, i2c.SLOW)   sda = nil   scl = nil
    ads1115.reset()
    adc0 = ads1115.ads1115(id, addr)
    adc1 = ads1115.ads1115(id, addr)
    adc2 = ads1115.ads1115(id, addr)
    adc3 = ads1115.ads1115(id, addr)

    adc0:setting(ads1115.GAIN_6_144V, ads1115.DR_128SPS, ads1115.SINGLE_0, ads1115.CONTINUOUS)
    adc1:setting(ads1115.GAIN_6_144V, ads1115.DR_128SPS, ads1115.SINGLE_1, ads1115.CONTINUOUS)
    adc2:setting(ads1115.GAIN_6_144V, ads1115.DR_128SPS, ads1115.SINGLE_2, ads1115.CONTINUOUS)
    adc3:setting(ads1115.GAIN_6_144V, ads1115.DR_128SPS, ads1115.SINGLE_3, ads1115.CONTINUOUS)

    tmr.delay(10*1000)

    function read_ADS1115()
        t1=tmr.now()
        volt0 = adc0:read()
        volt1 = adc1:read()
        volt2 = adc2:read()
        volt3 = adc3:read()
        t2=tmr.now()
        print("read, t2-t1: ",(t2-t1)/1000)
        print(volt0, volt1, volt2, volt3) 
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

readADS1115()
read_ADS1115()

--[[
read_ADS1115(0)

]]
