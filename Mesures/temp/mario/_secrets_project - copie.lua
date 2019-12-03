-- Petit script pour configurer les secrets dans ce projet
-- et que l'on n'aimerait pas être exportés sur Internet (github)
-- Il faut donc modifier le .gitignore avec secrets*.lua
-- il faut le renommer en 'secrets_project.lua' et sera exécuté
-- par 'boot2.lua' au moment du boot

function secrets_project()
    print("\n secrets_project.lua   zf191029.2116   \n")

    influxdb_url="http://www.aaa.ml:8086/write?db=xxx&u=yyy&p=zzz"
    print("influxdb_url: "..influxdb_url)

end
secrets_project()
secrets_project=nil
