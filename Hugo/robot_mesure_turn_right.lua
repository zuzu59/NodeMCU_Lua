--Programme pour faire tourner aleatoirement le robot à droite ou à gauche tant qu'il soit à moins de 20cm de l'obstacle
--hv20180717.1613

--parametres pour le module ultra son 
ztrig=5
zecho=6
ztstart=0
ztstop=0
gpio.mode(ztrig, gpio.OUTPUT)
gpio.write(ztrig, gpio.LOW)
gpio.mode(zecho, gpio.INT, gpio.PULLUP)

--parametres pour les moteurs
pin_a_speed = 1
pin_a_dir = 3
pin_b_speed = 2
pin_b_dir = 4
FWD = gpio.LOW
REV = gpio.HIGH
duty = 1023

--initialise moteur A
gpio.mode(pin_a_speed,gpio.OUTPUT)
gpio.write(pin_a_speed,gpio.LOW)
pwm.setup(pin_a_speed,1000,duty) --PWM 1KHz, Duty 1023
pwm.start(pin_a_speed)
pwm.setduty(pin_a_speed,0)
gpio.mode(pin_a_dir,gpio.OUTPUT)

--initialise moteur B
gpio.mode(pin_b_speed,gpio.OUTPUT)
gpio.write(pin_b_speed,gpio.LOW)
pwm.setup(pin_b_speed,1000,duty) --PWM 1KHz, Duty 1023
pwm.start(pin_b_speed)
pwm.setduty(pin_b_speed,0)
gpio.mode(pin_b_dir,gpio.OUTPUT)

-- timer personnelle
hvtimer1=tmr.create() 
hvtimer2=tmr.create()

-- speed is 0 - 100
function motor(pin_speed, pin_dir, dir, speed)
    gpio.write(pin_dir,dir)
    pwm.setduty(pin_speed, (speed * duty) / 100)
end

function motor_a(dir, speed)
    motor(pin_a_speed, pin_a_dir, dir, speed)
end
    
function motor_b(dir, speed)
    motor(pin_b_speed, pin_b_dir, dir, speed)
end

--Robot avance, s'arrete, tourne à droite, tourne à gauche
function avance_robot()
    t=math.random(1,2)
    --print(t)
    motor_a(FWD, 60)
    motor_b(FWD, 60)
end
function stop_robot()
    motor_a(FWD, 0)
    motor_b(FWD, 0)
end

function turn_right_robot()
    motor_a(FWD, 60)
    motor_b(REV, 60)
end
function turn_left_robot()
    motor_a(REV, 60)
    motor_b(FWD, 60)
end

--start pulse10 us
function zmesure_pulse()
    gpio.write(ztrig, gpio.HIGH)
    tmr.delay(10)
    gpio.write(ztrig, gpio.LOW)
end

-- mesure la distance et il s'arrete si < 20cm
function zmesure()
    if gpio.read(zecho)==1 then 
        ztstart=tmr.now()
    else
        ztstop=tmr.now() 
        zlength=360*(ztstop-ztstart)/2/10000
        
            if zlength>200 then zlength=0 end 
            if zlength<20 then 
            turn_right_robot() 
            tmr.alarm(hvtimer1, 1000, tmr.ALARM_SINGLE, avance_robot) 
            end

        print("distance [cm]: "..math.floor(zlength))
    end
end

gpio.trig(zecho, "both", zmesure)
tmr.alarm(hvtimer2, 1000, tmr.ALARM_AUTO, zmesure_pulse)


avance_robot()
