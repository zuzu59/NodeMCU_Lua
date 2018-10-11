-- Petit script pour afficher les infos actuel du WIFI
print("\n wifi_info.lua   zf180824.2000   \n")

local zmodewifi=wifi.getmode()

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
    print("AP MAC:\n\t"..wifi.ap.getmac())
    print("AP IP:\n\t"..wifi.ap.getip())
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
