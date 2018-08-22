--Programme pour choisir l'intensité des leds 
--hv20180711.1702

zpin1=1
zpin2=2

pwm.setup(zpin1, 100, 1022)
pwm.start(zpin1)

pwm.setup(zpin2, 100, 100)
pwm.start(zpin2)
