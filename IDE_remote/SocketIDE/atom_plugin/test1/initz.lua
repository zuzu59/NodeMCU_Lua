--Script de bootstrap, test au moment du boot qui a été la cause de boot.

print("\n init.lua zf191021.0914 \n")

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
  -- charge ses propres secrets
  f= "secrets_energy.lua"    if file.exists(f) then dofile(f) end

  -- configure le WIFI
  f= "wifi_ap_stop.lua"   if file.exists(f) then dofile(f) end
  f= "wifi_cli_conf.lua"   if file.exists(f) then dofile(f) end
  f= "wifi_cli_start.lua"   if file.exists(f) then dofile(f) end

  --[[
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
  ]]

  plugtimer1=tmr.create()
  plugtimer1:alarm(1*1000,  tmr.ALARM_AUTO, function()
    local ip = wifi.sta.getip()
    if ip then
      plugtimer1:unregister()
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
