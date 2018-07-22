-- Enclenche le mode configuration WIFI
print("\nzf180718.1107\n")

function get_ip()
    if wifi.sta.getip() == nil then
        print("Connecting to AP...")
    else
        tmr.stop(0)
        print("Connected! IP: ",wifi.sta.getip())
        tmr.alarm(0,3000,tmr.ALARM_SINGLE, function() node.restart() end)
    end
end

wifi.sta.disconnect()
wifi.sta.clearconfig()
print("\nwifi config http://192.168.4.1\n")
tmr.alarm(0, 1000, tmr.ALARM_AUTO , get_ip)
enduser_setup.start()