 #!/bin/sh
chmod +x luatool.py 
./luatool.py --port /dev/ttyUSB0 -f websocket.lua -c
./luatool.py --port /dev/ttyUSB0 -f main.lua -c
./luatool.py --port /dev/ttyUSB0 -f init.lua
