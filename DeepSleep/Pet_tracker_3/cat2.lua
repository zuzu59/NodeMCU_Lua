-- fonction cat() pour afficher le contenu d'un fichier dans la flash
print("\n cat2.lua   zf200725.1319   \n")
print("\nusage:")
print("   cat2(\"filename\")")

zfilei = ""
zline = ""
ztmr_cat1 = tmr.create()

function zprintline()
    print(string.sub(zline,1,string.len(zline)-1))
    zline = file.readline()
    if zline == nil then
        ztmr_cat1:unregister()
        file.close(zfilei)
    end
end

function cat2()
    zfilei = file.open(z_logs_ap_wifi, "r")
    zline = file.readline()
    ztmr_cat1:alarm(50, tmr.ALARM_AUTO, zprintline)
end

