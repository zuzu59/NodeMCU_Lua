-- Petit script pour afficher les infos actuel du WIFI
print("\n wifi_info.lua   zf181119.0014   \n")

local zmodewifi=wifi.getmode()

--wifi.NULLMODE, wifi.STATION, wifi.SOFTAP, wifi.STATIONAP

if zmodewifi == wifi.NULLMODE then
    print("WIFI OFF")
elseif zmodewifi == wifi.STATION then
    print("WIFI mode CLI")
    print("Connected IP:\n",wifi.sta.getip())
    do
        local sta_config=wifi.sta.getconfig(true)
        print(string.format("Current client config:\n\tssid:\"%s\"\tpassword:\"%s\"\n\tbssid:\"%s\"\tbssid_set:%s", sta_config.ssid, sta_config.pwd, sta_config.bssid, (sta_config.bssid_set and "true" or "false")))
    end
elseif zmodewifi == wifi.SOFTAP then
    print("WIFI mode AP")
    print("AP MAC:\n",wifi.ap.getmac())
    print("AP IP:\n",wifi.ap.getip())
    print("AP Connect:\n",wifi.ap.getconfig())
elseif zmodewifi == wifi.STATIONAP then
    print("WIFI mode CLI+AP")
    print("Connected IP:\n",wifi.sta.getip())
    do
        local sta_config=wifi.sta.getconfig(true)
        print(string.format("Current client config:\n\tssid:\"%s\"\tpassword:\"%s\"\n\tbssid:\"%s\"\tbssid_set:%s", sta_config.ssid, sta_config.pwd, sta_config.bssid, (sta_config.bssid_set and "true" or "false")))
    end
    print("AP MAC: "..wifi.ap.getmac())
    print("AP IP: "..wifi.ap.getip())
end
