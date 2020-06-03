-- Scripts pour tester l'affichage des erreurs quand on se trouve ne remote telnet
-- source: https://www.lua.org/pil/8.4.html
-- source: https://riptutorial.com/lua/example/16000/using-pcall

--[[
Usage:
après l'avoir lancé on peut faire varier le contenu de la variable zerr pour cérer des erreurs répétitives

Commandes à envoyer via un terminal:
~.
./luatool.py --ip $zIP:$zport -f c.lua
#./luatool.py --ip $zIP:$zport --zrestart
telnet -rN $zIP $zport
status, err = pcall(function () dofile("c.lua") end)   if status==false then print("Error: ",err) end
zerr=nil
zerr=1
ztmr_tst_err:unregister()
]]

print("\n c.lua zf191030.1231 \n")

zerr=1
ztmr_tst_err = tmr.create()

-- le code à tester DOIT être encapsulé dans une fonction
function zfoo()
  print("toto: "..zerr)
end

-- timer pour générer des erreurs répétitives
ztmr_tst_err:alarm(3*1000,  tmr.ALARM_AUTO, function()
  -- test du code
  local status, err = pcall(function () zfoo() end)  if status==false then print("Error: ",err) end
end)


--
