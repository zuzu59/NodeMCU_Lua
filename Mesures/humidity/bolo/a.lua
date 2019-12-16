print("\n a.lua zf191216.1206 \n")

t2 = 1234

id = 0
sda = 5
scl = 6
addr = 0x40

r = ""
HUMIDITY = 0xE5
TEMPERATURE = 0xE3


function readHumi()
    i2c.start(id)
    i2c.address(id, addr, i2c.TRANSMITTER)
    i2c.write(id, HUMIDITY)
    i2c.stop(id)

    i2c.start(id)
    i2c.address(id, addr, i2c.RECEIVER)
    tmr.delay(20000)
        
    r = i2c.read(id,3)
    i2c.stop(id)

    print(r)
    return (bit.band((bit.lshift(string.byte(r,1),8)+string.byte(r,2)),0xfffc)*12500)/65536-600
end


function getHumidity()
    return tonumber(string.format("%.1f", tostring(readHumi()/100)))
end

i2c.setup(id, sda, scl, i2c.SLOW)

t2 = getHumidity()
print("Humidity: "..t2.." %")


