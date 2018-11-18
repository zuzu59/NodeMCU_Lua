-- Scripts de seconde chance pour réparer une boucle dans le restart

print("\n repair.lua zf181119.006 \n")

if file.exists("wifi_ap_start.lua") then dofile("wifi_ap_start.lua") end
if file.exists("telnet_srv.lua") then dofile("telnet_srv.lua") end

jobtimer1=tmr.create()
tmr.alarm(jobtimer1, 5*1000,  tmr.ALARM_AUTO, function()
    print("repair...")
end)
