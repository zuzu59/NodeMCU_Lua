-- Juste un tests pour voir si j'arrive à réduire et extraire à la mano des data d'un un gros JSON

-- Source: https://github.com/nodemcu/nodemcu-firmware/blob/master/lua_examples/sjson-streaming.lua

print("\n a_meteo3-tests.lua zf190306.1427 \n")

function set_json()
    zjson=[[
    {"city_info":{"name":"Lausanne","country":"Suisse","latitude":"46.5194190","longitude":"6.6337000","elevation":"495","sunrise":"07:06","sunset":"18:24"},"forecast_info":{"latitude":null,"longitude":null,"elevation":"561.0"},"current_condition":{"date":"04.03.2019","hour":"10:00","tmp":6,"wnd_spd":39,"wnd_gust":64,"wnd_dir":"SO","pressure":1006.4,"humidity":96,"condition":"Averses de pluie faible","condition_key":"averses-de-pluie-faible","icon":"https:\/\/www.prevision-meteo.ch\/style\/images\/icon\/averses-de-pluie-faible.png","icon_big":"https:\/\/www.prevision-meteo.ch\/style\/images\/icon\/averses-de-pluie-faible-big.png"},"fcst_day_0":{"date":"04.03.2019","day_short":"Lun.","day_long":"Lundi","tmin":2,"tmax":8,"condition":"Averses de pluie faible","condition_key":"averses-de-pluie-faible","icon":"https:\/\/www.prevision-meteo.ch\/style\/images\/icon\/averses-de-pluie-faible.png","icon_big":"https:\/\/www.prevision-meteo.ch\/style\/images\/icon\/averses-de-pluie-faible-big.png","hourly_data":{"0H00":{"ICON":"https:\/\/www.prevision-meteo.ch\/style\/images\/icon\/nuit-nuageuse.png","CONDITION":"Nuit nuageuse","CONDITION_KEY":"nuit-nuageuse","TMP2m":3.2,"DPT2m":0.1,"WNDCHILL2m":-0.1,"HUMIDEX":null,"RH2m":80,"PRMSL":1010.3,"APCPsfc":0,"WNDSPD10m":13,"WNDGUST10m":26,"WNDDIR10m":235,"WNDDIRCARD10":"SO","ISSNOW":0,"HCDC":"0.00","MCDC":"33.30","LCDC":"0.00","HGT0C":2500,"KINDEX":41,"CAPE180_0":"0.000","CIN180_0":0},"1H00":{"ICON":"https:\/\/www.prevision-meteo.ch\/style\/images\/icon\/nuit-nuageuse.png","CONDITION":"Nuit nuageuse","CONDITION_KEY":"nuit-nuageuse","TMP2m":2.5,"DPT2m":-2.5,"WNDCHILL2m":-0.3,"HUMIDEX":null,"RH2m":70,"PRMSL":1009.3,"APCPsfc":0,"WNDSPD10m":10,"WNDGUST10m":20,"WNDDIR10m":229,"WNDDIRCARD10":"SO","ISSNOW":0,"HCDC":"0.00","MCDC":"100.00","LCDC":"0.00","HGT0C":2500,"KINDEX":39,"CAPE180_0":"0.000","CIN180_0":0},"2H00":{"ICON":"https:\/\/www.prevision-meteo.ch\/style\/images\/icon\/nuit-nuageuse.png","CONDITION":"Nuit nuageuse","CONDITION_KEY":"nuit-nuageuse","TMP2m":2.4,"DPT2m":-3.1,"WNDCHILL2m":-0.4,"HUMIDEX":null,"RH2m":67,"PRMSL":1008.3,"APCPsfc":0,"WNDSPD10m":10,"WNDGUST10m":17,"WNDDIR10m":221,"WNDDIRCARD10":"SO","ISSNOW":0,"HCDC":"18.70","MCDC":"100.00","LCDC":"0.00","HGT0C":2600,"KINDEX":40,"CAPE180_0":"0.000","CIN180_0":0},"3H00":{"ICON":"https:\/\/www.prevision-meteo.ch\/style\/images\/icon\/nuit-nuageuse.png","CONDITION":"Nuit nuageuse","CONDITION_KEY":"nuit-nuageuse","TMP2m":2.5,"DPT2m":-3.4,"WNDCHILL2m":-0.3,"HUMIDEX":null,"RH2m":65,"PRMSL":1007.1,"APCPsfc":0,"WNDSPD10m":10,"WNDGUST10m":16,"WNDDIR10m":221,"WNDDIRCARD10":"SO","ISSNOW":0,"HCDC":"100.00","MCDC":"99.70","LCDC":"0.00","HGT0C":2600,"KINDEX":40,"CAPE180_0":"0.000","CIN180_0":0},"4H00":{"ICON":"https:\/\/www.prevision-meteo.ch\/style\/images\/icon\/nuit-nuageuse.png","CONDITION":"Nuit nuageuse","CONDITION_KEY":"nuit-nuageuse","TMP2m":2.8,"DPT2m":-2.4,"WNDCHILL2m":-0.4,"HUMIDEX":null,"RH2m":69,"PRMSL":1006,"APCPsfc":0,"WNDSPD10m":12,"WNDGUST10m":19,"WNDDIR10m":233,"WNDDIRCARD10":"SO","ISSNOW":0,"HCDC":"100.00","MCDC":"100.00","LCDC":"0.00","HGT0C":2500,"KINDEX":36,"CAPE180_0":"0.000","CIN180_0":0},"5H00":{"ICON":"https:\/\/www.prevision-meteo.ch\/style\/images\/icon\/nuit-nuageuse.png","CONDITION":"Nuit nuageuse","CONDITION_KEY":"nuit-nuageuse","TMP2m":3.9,"DPT2m":0.2,"WNDCHILL2m":0.7,"HUMIDEX":null,"RH2m":77,"PRMSL":1004.2,"APCPsfc":0,"WNDSPD10m":13,"WNDGUST10m":20,"WNDDIR10m":241,"WNDDIRCARD10":"SO","ISSNOW":0,"HCDC":"100.00","MCDC":"100.00","LCDC":"0.00","HGT0C":2500,"KINDEX":33,"CAPE180_0":"0.000","CIN180_0":0},
    ]]
end

function zget_json_key()
--    print("zget_json_key entrée...",zjson_stat)
    if zjson_stat==1 then
        p1=string.find(zjson, [["hourly_data":{]])
        if p1~=nil then
            print("trouvé le header: ",p1)
            zjson=string.sub(zjson,p1)
            print(string.sub(zjson,1,100))
            print("go go go...")
            zjson_stat=2
        end
    end
    if zjson_stat==2 then
--        print("len1: "..string.len(zjson))
        zjson_key='"'..zh..'H00":{'
        print("zjson_key: "..zjson_key)
        p1=string.find(zjson, zjson_key)
        print("p1: ",p1)
        if p1~=nil then
            zjson=string.sub(zjson,p1)
            print("zjson: ",string.sub(zjson,1,100))
--            p1,p2=string.find(zjson, '"CONDITION_KEY":"')
            p1,p2=string.find(zjson, '"APCPsfc":')

            
            print(p1,p2)
            if p1~=nil then
--                p3=string.find(zjson, '","',p2)
                p3=string.find(zjson, ',',p2)
                print(p3)
                if p3~=nil then
                    ztutu=string.sub(zjson,p2+1,p3-1)
                    print("ztutu: ",ztutu)
--                    print("len2: "..string.len(zjson))
                end
            end
        end
    end
--    print("zget_json_key sortie...",zjson_stat)
end


zhmin=10
zhmax=23
zh=zhmin
zjson_stat=1
zjson=""

function ztoto(c1)
--    print("ztoto entrée...")
    if zjson=="" then
        zjson=c1
    else
        zjson=zjson..c1
    end
--    print("zh: ",zh,"len(zjson): ",string.len(zjson))
    while zh<=zhmax do
        zget_json_key()
        if p1~=nil then
            zh=zh+1            
        else
            print("ouille ouille ouille, pas trouvé...")
            if string.len(zjson)>510 then
                zjson=string.sub(zjson,string.len(zjson)-500)
            end
            break
        end
    end
    if zh>zhmax then
        zjson=""
    end
--    print("ztoto sortie...")
end


--set_json()
--zjson_stat=1
--zget_json_all_keys()


--[[
set_json()
zjson_stat=1
zh=1
zget_json_key()
zh=2
zget_json_key()

set_json()
zjson_stat=1
zh=0
for i=0, 5 do
    zget_json_key()
    zh=zh+1
end

set_json()
print("len1: "..string.len(zjson))
zjson=string.sub(zjson,string.len(zjson)-500)
print("len2: "..string.len(zjson))
print("zjson1: ",string.sub(zjson,1,100))
]]


