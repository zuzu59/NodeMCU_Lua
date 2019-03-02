socket = require('socket')
s= socket.tcp()            
s:connect('91.121.52.89', 80)
s:send("GET /services/json/lausanne HTTP/1.0\r\n")
s:send("Host: www.prevision-meteo.ch\r\n\r\n")
while 1==1 do
	print(s:receive("*l"))
end