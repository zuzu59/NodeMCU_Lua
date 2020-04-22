-- Petit script pour configurer les secrets utilisés pour le wifi
-- et que l'on n'aimerait pas être exportés sur Internet (github)
-- Il faut donc modifier le .gitignore avec secrets*.lua
-- il faut le renommer en 'secrets_wifi.lua' et sera exécuté
-- par 'wifi_init.lua' une fois pour la configuration du WIFI

function secrets_wifi()
    print("\n secrets_wifi.lua   zf191108.1744   \n")

   -- cli_ssid="3g-s7"
   -- cli_ssid="3G-zf2"
   cli_ssid="xxx"
   cli_pwd="yyy"

    -- cli_ssid="voie4."
    -- cli_pwd="yyy"

    ap_ssid="NodeMCU"
    ap_pwd="yyy"

end
secrets_wifi()
