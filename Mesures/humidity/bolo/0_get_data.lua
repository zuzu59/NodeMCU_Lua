-- Lit le capteur I2C HTU21D de mesure d'humidité et de température
print("\n 0_get_data.lua zf191215.2057 \n")

-- https://cdn-shop.adafruit.com/datasheets/1899_HTU21D.pdf
-- Comparaison DHT22, AM2302, AM2320, AM2321, SHT71, HTU21D, Si7021, BME280
-- http://www.kandrsmith.org/RJS/Misc/Hygrometers/calib_many.html
-- Il est compatible avec le capteur SI7021 mais pas avec la lib SI7021 du NodeMCU Lua :-(

-- http://electromag1.wifeo.com/capteurs-de-temperature-et-humidite-gy-21-et-si7021.php
-- source: https://github.com/famzah/nodemcu/tree/master/HTU21D-TLS
-- source2: https://github.com/tebben/NodeMCU
-- source3: https://github.com/codywon/NodeMCU-2


id = 0
sda = 1
scl = 2
addr = 0x40
HUMIDITY = 0xE5
TEMPERATURE = 0xE3
SOFTRESET = 0xFE

trig = 4
gpio.mode(trig, gpio.OUTPUT)
gpio.write(trig, gpio.HIGH)


i2c.setup(id, sda, scl, i2c.SLOW)
i2c.start(id)
tmr.delay(1*1000)

i2c.address(id, addr, i2c.TRANSMITTER)
i2c.write(id, SOFTRESET)
tmr.delay(20*1000)


i2c.address(id, addr, i2c.TRANSMITTER)
i2c.write(id, HUMIDITY)
i2c.address(id, addr, i2c.RECEIVER)
tmr.delay(50*1000)

gpio.write(trig, gpio.LOW)
tmr.delay(0.1*1000)
gpio.write(trig, gpio.HIGH)

r = i2c.read(id,3)
print(string.byte(r))
print(string.byte(r,2))
print(string.byte(r,3))



--i2c.address(id, addr, i2c.RECEIVER)

--[[
i2c.stop(id)


tmr.delay(17*1000)


i2c.start(id)
r = i2c.read(id,3)
i2c.stop(id)

print(string.byte(r))
print(string.byte(r,2))
print(string.byte(r,3))
]]

tmr.delay(1*1000)
i2c.stop(id)
