-- Petit script pour afficher les infos actuel du WIFI
print("\n wifi_info.lua   zf191030.1911   \n")

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
    print("WIFI mode AP\n")
    print("AP IP: ", wifi.ap.getip())
    print("Current AP config:")
    local ap_config=wifi.ap.getconfig(true)
    print("\tssid:", ap_config.ssid)
    print("\tpassword:", ap_config.pwd)
    print("\tbssid:", wifi.ap.getmac())
elseif zmodewifi == wifi.STATIONAP then
    print("WIFI mode CLI+AP\n")
    print("CLIENT IP:\n",wifi.sta.getip())
    local sta_config=wifi.sta.getconfig(true)
    print("Current CLIENT config:")
    print("\tssid:", sta_config.ssid)
    print("\tpassword:", sta_config.pwd)
    print("\tbssid:", sta_config.bssid.."\n")
    print("AP IP: ", wifi.ap.getip())
    print("Current AP config:")
    local ap_config=wifi.ap.getconfig(true)
    print("\tssid:", ap_config.ssid)
    print("\tpassword:", ap_config.pwd)
    print("\tbssid:", wifi.ap.getmac())
end
