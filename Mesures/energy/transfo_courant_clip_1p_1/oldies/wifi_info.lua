-- Petit script pour afficher les infos actuel du WIFI
print("\n wifi_info.lua   zf190727.1220   \n")

local zmodewifi=wifi.getmode()

--wifi.NULLMODE, wifi.STATION, wifi.SOFTAP, wifi.STATIONAP

if zmodewifi == wifi.NULLMODE then
    print("WIFI OFF")
elseif zmodewifi == wifi.STATION then
    print("WIFI mode CLI")
    print("Connected IP:\n",wifi.sta.getip())
    local sta_config=wifi.sta.getconfig(true)
    print("Current client config:")
    print("\tssid:", sta_config.ssid)
    print("\tpassword:", sta_config.pwd)
    print("\tbssid:", sta_config.bssid)
elseif zmodewifi == wifi.SOFTAP then
    print("WIFI mode AP")
    print("AP MAC:\n",wifi.ap.getmac())
    print("AP IP:\n",wifi.ap.getip())
    print("AP Connect:\n",wifi.ap.getconfig())
elseif zmodewifi == wifi.STATIONAP then
    print("WIFI mode CLI+AP")
    print("Connected IP:\n",wifi.sta.getip())
    local sta_config=wifi.sta.getconfig(true)
    print("Current client config:")
    print("\tssid:", sta_config.ssid)
    print("\tpassword:", sta_config.pwd)
    print("\tbssid:", sta_config.bssid)
    print("AP MAC: ", wifi.ap.getmac())
    print("AP IP: ", wifi.ap.getip())
end
