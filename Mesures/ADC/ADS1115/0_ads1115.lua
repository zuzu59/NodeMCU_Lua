-- Lit le le petit convertisseur ADC ADS1115

function readADS1115()
    if verbose then print("\n 0_ads1115.lua   zf200126.1709 \n") end
    
    id = 0   sda = 5   scl = 6   addr = 0x48
    
    i2c.setup(id, sda, scl, i2c.SLOW)   sda = nil   scl = nil

    function read_ADS1115(ADCnum)
        ads1115.reset()
        adc1 = ads1115.ads1115(id, addr)

        -- single shot
--        adc1:setting(ads1115.GAIN_6_144V, ads1115.DR_128SPS, ads1115.SINGLE_0, ads1115.SINGLE_SHOT)
        -- continuous mode
        adc1:setting(ads1115.GAIN_6_144V, ads1115.DR_128SPS, ads1115.SINGLE_0, ads1115.CONTINUOUS)

        -- start adc conversion and get result in callback after conversion is ready
--        adc1:startread(function(volt, volt_dec, adc, sign) 
--            print("startread",volt, volt_dec, adc, sign) 
--        end)

        -- continuous mode
--        adc1:setting(ads1115.GAIN_6_144V, ads1115.DR_128SPS, ads1115.SINGLE_0, ads1115.CONTINUOUS)
        tmr.delay(18*1000)
        t1=tmr.now()
        volt, volt_dec, adc, sign = adc1:read()
        t2=tmr.now()
        print("read, t2-t1: ",(t2-t1)/1000)
        print(volt, volt_dec, adc, sign) 
   
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
read_ADS1115(0)

--[[
read_ADS1115(0)

]]
