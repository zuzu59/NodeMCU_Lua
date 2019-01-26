print("tutu")
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,payload)
		   tgtfile = string.sub(payload,string.find(payload,"GET /")
           +5,string.find(payload,"HTTP/")-2)
		print(payload)
		if tgtfile == "" then tgtfile = "index.htm" end  

		local f = file.open(tgtfile,"r")
		if f ~= nil then
		    client:send(file.read())
            file.close()
		else
			client:send("<html>"..tgtfile.." not found - 404 error.<BR><a href='index.htm'>Home</a><BR>")
		end
--		client:close();
--		collectgarbage();
        conn:on("sent", function(c) c:close() end)
        f = nil
		tgtfile = nil
    end)
end)
