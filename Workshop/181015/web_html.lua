-- petit script pour le HTML du serveur web

print("\n web_html.lua   hv180907.1542  \n")

--Partie HTML et CSS pour la page web
function web_html()  
    buf = "<!DOCTYPE html><html><body><meta charset='utf-8' name='viewport' content='width=device-width, initial-scale=1.0'>\n" 
    buf = buf .. "<h1>Contrôler le robot : </h1>"
    buf = buf .. "<a href='?pin=F'><button id='bf'>F</button></a><br>\n"
    buf = buf .. "<a href='?pin=L'><button id='bl'>L</button></a><a href='?pin=S'><button id='bs'>S</button></a><a href='?pin=R'><button id='br'>R</button></a></br>\n"
    buf = buf .. "<a href='?pin=B'><button id='bb'>B</button></a>\n"
    buf = buf .. "<h1> Vitesse : </h1>\n" 
    buf = buf .. "<a href='?pin=SL'><button id='bsl'>Low</button></a><a href='?pin=SM'><button id='bsm'>Mid</button></a><a href='?pin=SF'><button id='bsf'>Fast</button></a>\n" 
    buf = buf .. "<h1> Robot : </h1>\n" 
    buf = buf .. "<a href='?pin=A'><button id='ba'>A</button></a><a href='?pin=ML'><button id='bml'>ML</button></a>\n"
    buf = buf .. "<h1> Tests : </h1>\n" 
    buf = buf .. "<a href='?pin=T1'><button id='bt1'>Start</button></a><a href='?pin=T2'><button id='bt2'>Reboot</button></a>"
    buf = buf .. "<a href='?pin=T3'><button id='bt3'>T3</button></a><a href='?pin=T4'><button id='bt4'>T4</button></a>\n"
    buf = buf .. "<style>\n"
    buf = buf .. "#bf, #bb, #bl, #br, #bs, #bsl, #bsm, #bsf, #ba, #bml, #bt1, #bt2, #bt3, #bt4{font-size:10px; position:relative; height:50px; width:50px;}\n"
    buf = buf .. "#bf, #bb {left:50px;}\n"   
    buf = buf .. "h1 {font-size:15px;}\n"   
    buf = buf .. "</style>\n"   
end
