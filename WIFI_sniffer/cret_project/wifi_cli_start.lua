-- Petit script pour connecter le NodeMCU sur un AP Wifi avec l'accompte sauvé en EEPROM

function wifi_cli_start()
    print("\n wifi_cli_start.lua   zf191030.1358   \n")
    
    local zmodewifi=wifi.getmode()
    if zmodewifi == wifi.NULLMODE then
        print("cliWIFI mode CLI only")
        wifi.setmode(wifi.STATION,save)
    elseif zmodewifi == wifi.SOFTAP then
        print("cliWIFI mode AP+CLI")
        wifi.setmode(wifi.STATIONAP,save)
    end
    wifi.sta.autoconnect(1)
    wifi.sta.connect()
    --f= "wifi_get_ip.lua"   if file.exists(f) then dofile(f) end
end

wifi_cli_start()
--wifi_cli_start=nil
