-- Lit le capteur I2C HTU21D de mesure d'humidité et de température
print("\n 0_htu21d.lua zf191219.1920 \n")

-- module https://learn.sparkfun.com/tutorials/htu21d-humidity-sensor-hookup-guide/all
-- acahat https://www.aliexpress.com/item/32480177429.html
-- schéma https://github.com/sparkfun/HTU21D_Breakout/blob/master/hardware/SparkFun_HTU21D_Breakout.pdf
-- data sheet https://cdn.sparkfun.com/assets/6/a/8/e/f/525778d4757b7f50398b4567.pdf
-- Comparaison DHT22, AM2302, AM2320, AM2321, SHT71, HTU21D, Si7021, BME280
--             http://www.kandrsmith.org/RJS/Misc/Hygrometers/calib_many.html
-- théorie http://electromag1.wifeo.com/capteurs-de-temperature-et-humidite-gy-21-et-si7021.php
-- source lua: https://github.com/tebben/NodeMCU

-- ATTENTION: il n'y a seulement que certaines combinaisons de pins qui fonctionnent avec le capteur HTU21D avec le NodeMCU !

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

r = nil
print("Temperature: "..readTemp().." °C")
print("Humidity: "..readHumi().." %")
