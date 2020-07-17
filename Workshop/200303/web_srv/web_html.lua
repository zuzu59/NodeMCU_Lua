-- petit script pour le HTML du serveur web

print("\n web_html.lua   zf200717.1801  \n")

--Partie HTML et CSS pour la page web
function html_home()  
    buf = "<!DOCTYPE html><html><body><meta charset='utf-8' name='viewport' content='width=device-width, initial-scale=1.0'>\n" 
    buf = buf .. "<h1>Petit serveur WEB sur NodeMCU  1802  </h1>\n"
    buf = buf .. "Usage: <br><br>\n"
    buf = buf .. "pour allumer la LED: <a href=\"http://192.168.4.1/?led=on\">http://192.168.4.1/?led=on</a><br>\n"
    buf = buf .. "pour éteindre la LED: <a href=\"http://192.168.4.1/?led=off\">http://192.168.4.1/?led=off</a><br>\n"
    buf = buf .. "pour éteindre la LED: <a href=\"http://192.168.4.1/?led=status\">http://192.168.4.1/?led=status</a><br>\n"
    buf = buf .. "pour flasher la LED 6x: <a href=\"http://192.168.4.1/?led=flash&fois=6\">http://192.168.4.1/?led=flash&fois=6</a><br>\n"   
    buf = buf .. "hello zuzu: <a href=\"http://192.168.4.1/?name=zuzu&phrase=hello\">http://192.168.4.1/?name=zuzu&phrase=hello</a><br>\n"   
    buf = buf .. "</body></html>"
end

function html_status()
    print("tutu")
    buf = "<!DOCTYPE html><html><body><meta charset='utf-8' name='viewport' content='width=device-width, initial-scale=1.0'>\n" 
    buf = buf .. "<h1>Hello, this is NodeMCU  1752  </h1>\n"
    if gpio.read(zLED) == 1 then
        buf = buf .. "<p>Led is off</p>\n"
    else
        buf = buf .. "<p>Led is on</p>\n"
    end
    buf = buf .. "<a href=\"../\">back...</a><br>\n"
    buf = buf .. "</body></html>"
end

function html_zuzu()
    print("c'est zuzu")
    buf = "<!DOCTYPE html><html><body><meta charset='utf-8' name='viewport' content='width=device-width, initial-scale=1.0'>\n" 
    buf = buf .. "<h1>Hello, this is NodeMCU  1800  </h1>\n"
    buf = buf .. _GET.phrase.." zuzu<br>\n"
    buf = buf .. "<br><a href=\"../\">back...</a><br>\n"
    buf = buf .. "</body></html>"
end
