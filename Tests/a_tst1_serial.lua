-- Juste pour tester le port série, envoie le caractères U toute les seconde
--- U en binaire c'est 1010101, parfait pour le 'voir' avec un oscilloscope

print("\n a_tst1_serial.lua zf190504.1316 \n")


test_1=tmr.create()
tmr.alarm(test_1, 1*1000,  tmr.ALARM_AUTO, function()
--tmr.alarm(test_1, 2.5*1000,  tmr.ALARM_SINGLE, function()
    print("U")
end)

--[[
tmr.stop(test_1)
tmr.start(test_1)
]]

