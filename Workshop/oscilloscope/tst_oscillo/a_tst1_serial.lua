-- Juste pour tester le port série, envoie une suite "UUUUU" 100x par seconde
-- On envoie 5x le caractère U
-- U en binaire c'est 1010101
-- on peut ainsi bien 'voir' avec un oscilloscope le port série

print("\n a_tst1_serial.lua zf190506.1402 \n")


test_1=tmr.create()
tmr.alarm(test_1, 0.01*1000,  tmr.ALARM_AUTO, function()
--tmr.alarm(test_1, 2.5*1000,  tmr.ALARM_SINGLE, function()
--    print("   ###    ")
--    uart.write(0, string.char(0)..string.char(0)..string.char(1)..string.char(3)..string.char(0).."U")
    uart.write(0, "UUUUU")
end)

--[[
tmr.stop(test_1)
tmr.start(test_1)
]]

