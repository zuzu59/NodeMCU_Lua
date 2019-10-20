# nodemcu-thingy

**THIS PACKAGE IS CURRENTLY UNDER DEVOLOPMENT AND TO BE CONSIDERED ALPHA**

NodeMCU Thingy is an [atom](https://atom.io/) package for "over the air" development on the NodeMCU platform.
It uses a websocket connection to the esp8266 for communication, so in an ideal world the USB cable should be needed only to upload the basic firmware and the initial websocket server to the NodeMCU.


Features include:

* Upload of files to the NodeMCU
* Download of files from the NodeMCU
* Deletion of files on the NodeMCU
* Interactive Console

![demo](https://github.com/holtermp/nodemcu-thingy/blob/master/screencasts/console.gif)

**Setup**

*Get the firmware*

Flash your esp8266 with a current NodeMCU firmware. I recommend using a firmware built with Marcel Stoer's excellent online tool at  https://nodemcu-build.com/

Select branch ```master``` and at least the following 9 modules:
 * ```bit```
 * ```crypto```
 * ```file```
 * ```gpio```
 * ```net```
 * ```node```
 * ```tmr```
 * ```uart```
 * ```wifi```

Note that ```bit``` and ```crypto``` are not selected by default.

This creates two versions of the firmware: integer and float. If you do not know which one to use, the integer version is probably ok for you.

*Flash the firmware*

Download ```esptool.py``` from https://github.com/espressif/esptool.

Flash the firmware to the esp8266 with (use the appropriate ```--port``` parameter)
```
esptool.py --port /dev/ttyUSB0 erase_flash
esptool.py --port /dev/ttyUSB0 write_flash -fm dio 0x00000 nodemcu-master*.bin
```

which should produce an output like:

```
esptool.py v1.3-dev
Connecting...
Running Cesanta flasher stub...
Erasing flash (this may take a while)...
Erase took 6.6 seconds

esptool.py v1.3-dev
Connecting...
Auto-detected Flash size: 32m
Running Cesanta flasher stub...
Flash params set to 0x0240
Writing 401408 @ 0x0... 401408 (100 %)
Wrote 401408 bytes at 0x0 in 34.8 seconds (92.3 kbit/s)...
Leaving...
```
Give it a few seconds to reboot.


*Install websocket server*

Cd to ```.atom/packages/nodemcu-thingy/mcu/```.
Change ```init.lua``` to match your wireless LAN.

```
station_cfg.ssid="your ssid"
station_cfg.pwd="yout wifi password"
wifi.sta.sethostname("your hostname for the esp8266")
```
Edit ```upload.sh``` and check if the ```--port``` value matches your system and execute ```bash upload.sh```.

This takes some time and you should see a lot of lines like
```
->file.writeline([==[end]==]) -> ok
```
ending in
```
->file.flush() -> ok
->file.close() -> ok
--->>> All done <<<---
```
Restart the esp8266 by pressing the ```RST``` button on the esp8266.

After a few seconds you should be able to ping the esp8266 using the value from ```wifi.sta.sethostname()```

*Configure package nodemcu-thingy*


Open Atom's preferences screen (```Edit->Preferences``` or ```Ctrl-,```). Open ```Packages```. Find package ```nodemcu-thingy``` and click ```Settings```.
Enter the ip address or hostname of your esp8266 (value from ```wifi.sta.sethostname()```) into the ```host``` field.

Activate the package with ```Packages->nodemcu-thingy->Toggle```

Click ```Connect```.
If everything worked the red ```Disconnected``` changes to a green ```Connected``` after a few seconds.

![demo](https://github.com/holtermp/nodemcu-thingy/blob/master/screencasts/connect.gif)

You are now good to go.
Very brave programmers can now unhook the usb cable from the computer and run
the esp8266 on some other power source (probably a phone charger).

*Use package nodemcu-thingy*


You can upload, download, erase files on the esp8266.

The installation process has installed 3 files on the esp8266 which are protected from modification by this package:
* ```websocket.lc``` implements the websocket protocol
* ```main.lc``` implements the server side functions for this package
* ```init.lua``` called by the NodeMCU firmware on startup.
 * sets up the wifi connection
 * starts the websocket server
 * calls ```userinit.lua``` if present.

(The original implementation of these 3 files is borrowed from [nodemcu-webide](https://github.com/creationix/nodemcu-webide))

To implement your own functionality upload a custom ```userinit.lua``` to start your own custom code.

![demo](https://github.com/holtermp/nodemcu-thingy/blob/master/screencasts/upload.gif)

See https://nodemcu.readthedocs.io/en/master/ for the all the good stuff you can use...










*Credits*

The Websocket server on the NodeMCU is a slightly modified version of the one in Creationix's
[nodemcu-webide](https://github.com/creationix/nodemcu-webide)

The Python luatool comes from 4ref0nt@gmail.com  (http://esp8266.ru)
