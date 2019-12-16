-- http://www.esp8266.com/viewtopic.php?f=19&t=771
-- Scan for I2C devices

print("\n b.lua zf191216.1158 \n")

id=0
sda=5
scl=6

-- initialize i2c, set pin1 as sda, set pin0 as scl

print("start...")
i2c.setup(id,sda,scl,i2c.SLOW)

for i=0,127 do
  i2c.start(id)
  resCode = i2c.address(id, i, i2c.TRANSMITTER)
  i2c.stop(id)
  if resCode == true then print("We have a device on address 0x" .. string.format("%02x", i) .. " (" .. i ..")") end
end
print("stop...")