-- Lit le capteur I2C HTU21D de mesure d'humidité et de température
-- https://github.com/zuzu59/NodeMCU_Lua/tree/master/Mesures/humidity/bolo-thingspeak/docu/HTU21D.txt

function readHTU21D()
    if verbose then print("\n 0_htu21d.lua   zf200119.1517 \n") end
    
    id = 0   sda = 5   scl = 6   addr = 0x40
    HUMIDITY = 0xE5   TEMPERATURE = 0xE3
    i2c.setup(id, sda, scl, i2c.SLOW)   sda = nil   scl = nil

    function read_HTU21D(zreg, zdelay)
        i2c.start(id)   i2c.address(id, addr, i2c.TRANSMITTER)
        i2c.write(id, zreg)   i2c.stop(id)
        i2c.start(id)   i2c.address(id, addr, i2c.RECEIVER)
        tmr.delay(zdelay)
        r = i2c.read(id,3)   i2c.stop(id)
        return r
    end

    function readTemp()
        r = read_HTU21D(TEMPERATURE, 50000)
        r = (bit.band((bit.lshift(string.byte(r,1),8)+string.byte(r,2)),0xfffc)*17572)/65536-4685
        return tonumber(string.format("%.1f", tostring(r/100)))
    end

    function readHumi()
        r = read_HTU21D(HUMIDITY, 16000)
        r = (bit.band((bit.lshift(string.byte(r,1),8)+string.byte(r,2)),0xfffc)*12500)/65536-600
        return tonumber(string.format("%.1f", tostring(r/100)))
    end

    ztemp1=readTemp()   zhum1=readHumi()
    if verbose then print("Temperature: "..ztemp1.." °C") end
    if verbose then print("Humidity: "..zhum1.." %") end

    id=nil sda=nil scl=nil addr=nil HUMIDITY=nil TEMPERATURE=nil r=nil
    read_HTU21D=nil readTemp=nil readHumi=nil readHTU21D=nil
    if verbose then print(node.heap()) end
    collectgarbage()
    if verbose then print(node.heap()) end
end

readHTU21D()
