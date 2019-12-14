-- Lit le capteur I2C HTU21D de mesure d'humidité et de température
print("\n 0_get_data.lua zf191214.1337 \n")

-- https://cdn-shop.adafruit.com/datasheets/1899_HTU21D.pdf
-- Comparaison DHT22, AM2302, AM2320, AM2321, SHT71, HTU21D, Si7021, BME280
-- http://www.kandrsmith.org/RJS/Misc/Hygrometers/calib_many.html
-- Il est compatible avec le capteur SI7021 mais pas avec la lib SI7021 du NodeMCU Lua :-(

-- source: https://github.com/famzah/nodemcu/tree/master/HTU21D-TLS
-- source2: https://github.com/tebben/NodeMCU
-- source3: https://github.com/codywon/NodeMCU-2




function read_mesure()

    local sda, scl = 6, 5
    i2c.setup(0, sda, scl, i2c.SLOW) -- call i2c.setup() only once
    si7021.setup()

    fwrev = si7021.firmware()
    print(string.format("FW: %X\r\n", fwrev))

end


read_mesure()
