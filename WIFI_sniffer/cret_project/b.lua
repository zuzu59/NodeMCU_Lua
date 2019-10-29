-- Scripts pour tester le sniffer de smartphone qui essaient de se connecter sur des AP WIFI
-- source: https://nodemcu.readthedocs.io/en/dev/modules/wifi/#wifieventmonregister

print("\n b.lua zf191029.2204 \n")

--f= "set_time.lua"   if file.exists(f) then dofile(f) end

-- apzuzu6 38:2c:4a:4e:d3:d8

zmac_adrs={}
zmac_adrs[#zmac_adrs+1]="b8:d7:af:a6:bd:86,S7 zf,0,0,0"
zmac_adrs[#zmac_adrs+1]="cc:c0:79:7d:f5:d5,S7 Melanie,0,0,0"
zmac_adrs[#zmac_adrs+1]="5c:f9:38:a1:f7:f0,MAC zf,0,0,0"
zmac_adrs[#zmac_adrs+1]="d8:30:62:5a:d6:3a,IMAC Maman,0,0,0"
zmac_adrs[#zmac_adrs+1]="88:e9:fe:6b:ec:1e,MAC Luc,0,0,0"
zmac_adrs[#zmac_adrs+1]="0c:2c:54:b3:c5:1a,HU Nicolas,0,0,0"
zmac_adrs[#zmac_adrs+1]="c0:a6:00:bf:4e:43,IPHONE Maeva,0,0,0"
--[[
zmac_adrs[#zmac_adrs+1]="80:58:f8:44:09:ce, ,-30,0,0"
zmac_adrs[#zmac_adrs+1]="02:07:49:35:67:10, ,-58,0,0"
zmac_adrs[#zmac_adrs+1]="c0:ee:fb:4a:ff:28, ,-55,0,0"
zmac_adrs[#zmac_adrs+1]="da:a1:19:ed:93:84, ,-59,0,0"
zmac_adrs[#zmac_adrs+1]="02:c5:a0:96:05:bd, ,-32,0,0"
zmac_adrs[#zmac_adrs+1]="da:a1:19:a6:a0:93, ,-56,0,0"
zmac_adrs[#zmac_adrs+1]="46:79:22:70:f5:b8, ,-59,0,0"
zmac_adrs[#zmac_adrs+1]="86:27:18:64:f8:c0, ,-57,0,0"
zmac_adrs[#zmac_adrs+1]="da:a1:19:89:2c:80, ,-59,0,0"
zmac_adrs[#zmac_adrs+1]="da:a1:19:01:85:98, ,-47,0,0"
]]

function zshow()
    print("coucou")
    for i=1, #zmac_adrs do
--        print(i,zmac_adrs[i])
        zadrs, zname, zrssi, ztime0, ztime1 = zmac_adrs[i]:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")
        if tonumber(zrssi) < 0 then
            ztx = i.."-"..zadrs..", "..zname..", "..zrssi..", "..zround(zcalc_distance(zrssi),1).."m, "
            ztx = ztx..ztime_format(ztime_uncompress(ztime0))..", "..ztime_format(ztime_uncompress(ztime1))
            print(ztx)
            ztx = nil
        end
    end
end

function zsplit(zline)
    zadrs, zname, zrssi, ztime0, ztime1 = zline:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")
--    print("-", zadrs, zname, zrssi, ztime0, ztime1,"-")
end

function zmerge()
    zline=zadrs..","..zname..","..zrssi..","..ztime0..","..ztime1
    return zline
end

function find_adrs(zadrs)
    for i=1, #zmac_adrs do
        if zadrs == zmac_adrs[i]:match("([^,]+),[^,]+,[^,]+,[^,]+,[^,]+") then
--            print("find: "..zmac_adrs[i])
            return i
        end
    end
    return 1-1
end

function zsort_rssi()
    print("tri du tableau")
    table.sort(zmac_adrs, function(a,b)
        return a:match("[^,]+,[^,]+,([^,]+),[^,]+,[^,]+") < b:match("[^,]+,[^,]+,([^,]+),[^,]+,[^,]+")
    end)
end



--[[
zshow()
zsort_rssi()

zsplit(zmac_adrs[1])
print(zmerge())

print(find_adrs("88:e9:fe:6b:ec:1e"))
print(find_adrs("da:a1:19:b6:6b:50"))

print(find_adrs("88:e9:fe:6b:ec:1e"))
zsplit(zmac_adrs[5])
zrssi=-45   ztime0="10:19"   ztime1="10:19"
zmac_adrs[5]=zmerge()
print(find_adrs("88:e9:fe:6b:ec:1e"))

zmac_adrs=nil
zmac_adrs={}

]]

function zround(num, dec)
    local mult = 10^(dec or 0)
    return math.floor(num * mult + 0.5) / mult
end



--zadrs, zname, zrssi, ztime0, ztime1

function zsniff(T)
--    print("toto1950: "..T.RSSI)
    if T.RSSI > -60 then
        print("\n\tMAC: ".. T.MAC.."\n\tRSSI: "..T.RSSI)
--    ztime()
        z_adrs_mac_index=find_adrs(T.MAC)
        print("toto: -"..z_adrs_mac_index.."-")
        if z_adrs_mac_index == 0 then
            print("Oh une inconnue !")
            zmac_adrs[#zmac_adrs+1]=" , ,0,0,0"
            z_adrs_mac_index=#zmac_adrs
--            print("tutu: -"..zmac_adrs[z_adrs_mac_index].."-")
            zsplit(zmac_adrs[z_adrs_mac_index])
            zadrs=T.MAC
        else
--            print("titi: -")
            zsplit(zmac_adrs[z_adrs_mac_index])
        end
    --    zmac_adrs[T.MAC]["ztime"]=string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"])

        if tonumber(ztime0) == 0 then
            ztime0 = ztime_compress(rtctime.get())
        else
            if ztime_uncompress(ztime0) < ztime2019 then
                ztime0 = ztime_compress(rtctime.get())
            end
        end
        ztime1 = ztime_compress(rtctime.get())


        zrssi=T.RSSI
--[[
        if zrssi == 0 then
            zrssi=T.RSSI
        else
            zrssi=zround((4*zrssi+T.RSSI)/5, 0)
        end
]]
        if zname ~= " " then
            print("Bonjour "..zname.." !   "..zrssi)
        end
        zmac_adrs[z_adrs_mac_index]=zmerge()
    end
end

function zcalc_distance(zrssi2)
    zrssi_1m=-40    zn=2
    zdist=10^((zrssi_1m - zrssi2) / (10 * zn))
    return zdist
end

--[[
print("distance: "..zcalc_distance(-60).."m")

La formule pour calculer la distance est assez simple.

d = 10 ^ ((TxPower - RSSI) / (10 * n))

- TxPower est le RSSI mesuré à 1 m d'un point d'accès connu. Par exemple: -84 dB.
- n est la constante de propagation ou l'exposant d'affaiblissement de trajet. Par exemple: 2,7 à 4,3 (l'espace libre a n = 2 pour référence).
- RSSI est le RSSI mesuré
- d est la distance en mètre
]]


wifi.eventmon.register(wifi.eventmon.AP_PROBEREQRECVED, zsniff)

--[[

wifi.eventmon.unregister(wifi.eventmon.AP_PROBEREQRECVED)
zsort_rssi()   zshow()

]]
