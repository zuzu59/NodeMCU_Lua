print("\n a.lua zf191215.2112 \n")

t2 = 1234

trig = 4
gpio.mode(trig, gpio.OUTPUT)
gpio.write(trig, gpio.HIGH)


id = 0
sda = 1
scl = 2
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
    
    gpio.write(trig, gpio.LOW)
    tmr.delay(10)
    gpio.write(trig, gpio.HIGH)
    
    r = i2c.read(id,3)
    i2c.stop(id)
    print(r)
    return (bit.band((bit.lshift(string.byte(r,1),8)+string.byte(r,2)),0xfffc)*12500)/65536-600
end


function getHumidity()
    return tonumber(string.format("%.1f", tostring(readHumi()/100)))
end

tmr.delay(15000)
i2c.setup(id, sda, scl, i2c.SLOW)
tmr.delay(15000)

t2 = getHumidity()
print("Humidity: "..t2.." %")


