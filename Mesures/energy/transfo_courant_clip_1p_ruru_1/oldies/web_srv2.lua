-- petit script de serveur WEB avec Active Server Page ZYX
-- permet d'exécuter du code LUA inline dans l'HTML !

print("\n web_srv2.lua   zf200112.1926   \n")

-- envoie sur le port ouvert mais depuis l'environnement global !
function zout(zstring)
    if string.len(zstring) > 0 then
        zzclient:send(zstring)                      -- envoie le résultat du code lua inline
    end
end

-- envoie un fichier HTML sur le port. ATTENTION: longueur de la ligne maximale de 1'024 bytes !
function send_file(zclient, zfilename)
    print("start send html...")
    zclient:send("HTTP/1.1 200 OK\n")
    zclient:send("Content-Type: text/html\n\n")
    zzclient = zclient        -- export le port sur l'environnement global !
    if zfilename == "" then zfilename = "z_index.html" end
    file_web = file.open(zfilename, "r")
    if file_web then
        repeat
            local line = file_web:readline()
            if line then
                if string.find(line, "<%%") then
                    flag_lua_code = true        -- bascule sur le code lua inline
                    lua_code = ""
                elseif string.find(line, "%%>") then
                    flag_lua_code = false       -- revient sur le code HTML
                    loadstring(lua_code)()      --on exécute ici le code lua inline !
                    lua_code = nil
                elseif flag_lua_code then
                    lua_code = lua_code..line   -- récupère le code lua inline
                else
                    zclient:send(line)          -- envoie le code HTML
                end
            end
        until not line
        file_web:close()   file_web = nil   flag_lua_code=nil   zzclient=nil
    else
        zclient:send("<html><h1>"..zfilename.." not found - 404 error</h1><a href='/'>Home</a><br></html>")
    end
end

srv = net.createServer()
srv:listen(80, function(conn)
    conn:on("receive", function(client, request)
        _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
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
            send_file(client, file_html)   file_html=nil   _GET=nil
        end
    end)
    conn:on("sent", function(c) c:close() end)
end)
