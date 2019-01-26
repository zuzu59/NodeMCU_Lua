-- petit script pour le HTML du serveur web

print("\n web_html.lua   zf190119.2018  \n")

--Partie HTML et CSS pour la page web
function html_home()  
    buf = "<!DOCTYPE html><html><body><meta charset='utf-8' name='viewport' content='width=device-width, initial-scale=1.0'>\n" 
    buf = buf .. "<h1>Hello, this is NodeMCU WIFI Sniffer  2008  </h1>\n"
    buf = buf .. string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]) .. "<br><br>\n"
    buf = buf .. "<table border='1'><tr><th>MAC</th><th>Name</th><th>RSSI</th><th>Time</th></tr>\n"
    for k, v in pairs(zmac_adrs) do
        buf = buf .. "<tr><td>" .. k .. "</td>\n"
        buf = buf .. "<td>" .. tostring(zmac_adrs[k]["zname"]) .. "</td>\n"
        buf = buf .. "<td>" .. tostring(zmac_adrs[k]["zrssi"]) .. "</td>\n"
        buf = buf .. "<td>" .. tostring(zmac_adrs[k]["ztime"]) .. "</td>\n"
        buf = buf .. "</tr>\n"
    end
    buf = buf .. "</table>\n"
    buf = buf .. "</body></html>"
end

function html_status()  
    buf = "<!DOCTYPE html><html><body><meta charset='utf-8' name='viewport' content='width=device-width, initial-scale=1.0'>\n" 
    buf = buf .. "<h1>Hello, this is NodeMCU.  1608  </h1>\n"
    buf = buf .. "Toto\n"
    if gpio.read(zLED) == 1 then
        buf = buf .. "<p>Led is off</p>\n"
    else
        buf = buf .. "<p>Led is on</p>\n"
    end
    buf = buf .. "</body></html>"
end
