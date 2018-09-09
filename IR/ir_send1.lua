-- Petit script pour faire clignoter la LED IR

print("\n ir_send.lua  zf180906.1709  \n")

pin_ir_send = 8

gpio.mode(pin_ir_send,gpio.OUTPUT)
gpio.write(pin_ir_send,gpio.HIGH)
pwm.setup(pin_ir_send,50,512)
pwm.start(pin_ir_send)

