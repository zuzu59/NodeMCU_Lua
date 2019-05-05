-- petit script de serveur WEB avec Active Server Page ZYX
-- pour l'instant la partie ASP n'est que mono tâche !

print("\n web_srv2.lua   zf190314.1507   \n")

ztemp=12

-- envoie sur le port ouvert mais depuis l'environnement global !
function zout(zstring)
    zzclient:send(zstring)                      -- envoie le résultat du code lua inline
end

-- envoie un fichier HTML sur le port. ATTENTION: longueur de la ligne maximale de 1'024 bytes !
function send_file(zclient, zfilename)
    print("start send html...")
    zclient:send("HTTP/1.1 200 OK\n")
    zclient:send("Content-Type: text/html\n\n")
    zzclient = zclient        -- export le port sur l'environnement global !
    if zfilename == "" then zfilename = "z_index.html" end  
    if file.open(zfilename, "r") then
        repeat
            local line = file.read('\n')
            if line then
                if string.find(line, "<%%") then
--                    print("start lua...")
                    flag_lua_code = true        -- bascule sur le code lua inline
                    lua_code = ""
                elseif string.find(line, "%%>") then
--                    print("stop lua...")
                    flag_lua_code = false       -- revient sur le code HTML
--                    print("Et voici le code lua inline:\n"..lua_code)
                    loadstring(lua_code)()      --on exécute ici le code lua inline !
                elseif flag_lua_code then
--                    print(line)
                    lua_code = lua_code..line   -- récupère le code lua inline
                else
                    zclient:send(line)          -- envoie le code HTML
                end
            end
            until not line    
        file.close()
    else
        zclient:send("<html><h1>"..zfilename.." not found - 404 error</h1><a href='/'>Home</a><br></html>")
    end
end


srv = net.createServer()
srv:listen(80, function(conn)
    conn:on("receive", function(client, request)
        _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
        
    print("request: \n---\n"..request.."---")
--    print("method: ", method)   print("path: ", path)   print("vars: ", vars)
        
        if not string.find(request, "/favicon.ico") then
            print("coucou")
            if (method == nil) then
                _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
            end
            print("method: ", method)   print("path: ", path)   print("vars: ", vars)
            _GET = {}
            if (vars ~= nil) then
                for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                    _GET[k] = v
                    print(k..": "..v)
                end
            end
            file_html=string.gsub(path, "/", "")
            --        print("file_html: ",file_html)
            send_file(client, file_html)      
        end
    end)
    conn:on("sent", function(c) c:close() end)
end)


