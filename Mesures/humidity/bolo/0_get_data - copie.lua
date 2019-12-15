-- Lit le capteur I2C HTU21D de mesure d'humidité et de température
print("\n 0_get_data.lua zf191215.1329 \n")

-- https://cdn-shop.adafruit.com/datasheets/1899_HTU21D.pdf
-- Comparaison DHT22, AM2302, AM2320, AM2321, SHT71, HTU21D, Si7021, BME280
-- http://www.kandrsmith.org/RJS/Misc/Hygrometers/calib_many.html
-- Il est compatible avec le capteur SI7021 mais pas avec la lib SI7021 du NodeMCU Lua :-(

-- source: https://github.com/famzah/nodemcu/tree/master/HTU21D-TLS
-- source2: https://github.com/tebben/NodeMCU
-- source3: https://github.com/codywon/NodeMCU-2

scl = 1
sda = 2
id = 0
addr = 0x40
HUMIDITY = 0xE5
TEMPERATURE = 0xE3
SOFTRESET = 0xFE

print(scl, sda, id, addr, HUMIDITY, TEMPERATURE, SOFTRESET)

zspeed = i2c.setup(id, sda, scl, 500000)
print(zspeed)

i2c.start(id)
zerr = i2c.address(id, addr, i2c.TRANSMITTER)
i2c.stop(id)

print("ack: ",zerr)


--[[

i2c.write(id, SOFTRESET)
i2c.stop(id)

tmr.delay(20*1000)


i2c.start(id)
i2c.address(id, addr, i2c.TRANSMITTER)
i2c.write(id, HUMIDITY)
i2c.stop(id)

i2c.start(id)
i2c.address(id, addr, i2c.RECEIVER)
tmr.delay(50*1000)
r = i2c.read(id,3)
i2c.stop(id)


print(string.byte(r))
print(string.byte(r,2))
print(string.byte(r,3))

]]
