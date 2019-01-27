-- petit script de serveur WEB avec Active Server Page ZYX

print("\n web_srv2.lua   zf190127.1127   \n")

-- send a file from memory to the client; max. line length = 1024 bytes!
function send_file(zclient, zfilename)
    if zfilename == "" then zfilename = "index.html" end  
    if file.open(zfilename, "r") then
        repeat
            local line = file.read('\n')
            if line then
                if string.find(line, "<%%") then
                    print("start lua...")
                    lua_code = true
                elseif string.find(line, "%%>") then
                    print("stop lua...")
                    lua_code = false
                elseif lua_code then
                    print(line)
                else
                    zclient:send(line)
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
        
--    print("request: \n---\n"..request.."---")
--    print("method: ", method)   print("path: ", path)   print("vars: ", vars)
        
        if not string.find(request, "/favicon.ico") then
            print("coucou")
            if (method == nil) then
                _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
            end
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


