local bootreasons={
  [0]="power-on",
  [1]="hardware watchdog reset",
  [2]="exception reset",
  [3]="software watchdog reset",
  [4]="software restart",
  [5]="wake from deep sleep",
  [6]="external reset"
}

local ip = wifi.sta.getip()
if ip then
  print("already got:"..ip)
else
  print("Connecting...")
  wifi.setmode(wifi.STATION)
  ip_cfg={}
  ip_cfg.ip = "192.168.6.90"
  ip_cfg.netmask = "255.255.255.0"
  ip_cfg.gateway = "192.168.6.1"
  wifi.sta.setip(ip_cfg)
  station_cfg={}
  station_cfg.ssid="holternet"
  station_cfg.pwd="nemosushi_sushinemo"
  wifi.sta.sethostname("mybutton1")
  wifi.sta.config(station_cfg)
  wifi.sta.connect()
  wifi.sta.autoconnect(1)

  tmr.alarm(0, 1000, 1, function ()
    local ip = wifi.sta.getip()
    if ip then
      tmr.stop(0)
      print(ip)
    end
  end)
end
dofile("websocket.lc")
dofile("main.lc")
if file.exists("userinit.lua") then
  --[[
  0, power-on
  1, hardware watchdog reset
2, exception reset
3, software watchdog reset
4, software restart
5, wake from deep sleep
6, external reset
  ]]
  _ , reason = node.bootreason()
  if (reason<1 or reason > 3)  then
    dofile("userinit.lua")
  else
    print ("Bootreason="..reason.." ("..bootreasons[reason].."), skipping userinit.lua")
  end
else
  print("userinit.lua not found")
end
