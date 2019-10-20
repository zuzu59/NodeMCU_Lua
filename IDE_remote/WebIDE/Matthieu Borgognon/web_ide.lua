-- Petit WEB_IDE assez génial
-- Source: https://github.com/matbgn/NodeMCU/tree/master/lib/web-ide

print("\n web_ide.lua zf191020.1211 \n")


local mPort = 88

local function editor(aceEnabled) -- feel free to disable the shiny Ajax.org Cloud Editor
  local AceEnabled = aceEnabled == nil and true or aceEnabled
  srv = net.createServer(net.TCP)
  srv:listen(mPort, function(conn)
 
   local rnrn = 0
   local Status = 0
   local DataToGet = 0
   local method = ""
   local url = ""
   local vars = ""
 
   conn:on("receive", function(sck, payload)
     
     if Status == 0 then
         _, _, method, url, vars = string.find(payload, "([A-Z]+) /([^?]*)%??(.*) HTTP")
     end
     
     if method == "POST" then
     
         if Status == 0 then
             _, _, DataToGet, payload = string.find(payload, "Content%-Length: (%d+)(.+)")
             if DataToGet then
                 DataToGet = tonumber(DataToGet)
                 rnrn = 1
                 Status = 1                
             else
                 print("bad length")
             end
         end
         
         if Status == 1 then
             local payloadlen = string.len(payload)
             local mark = "\r\n\r\n"
             local i
             for i=1, payloadlen do                
                 if string.byte(mark, rnrn) == string.byte(payload, i) then
                     rnrn = rnrn + 1
                     if rnrn == 5 then
                         payload = string.sub(payload, i+1, payloadlen)
                         file.open(url, "w")
                         file.close() 
                         Status = 2
                         break
                     end
                 else
                     rnrn = 1
                 end
             end    
             if Status == 1 then
                 return 
             end
         end       
     
         if Status == 2 then
             if payload then
                 DataToGet = DataToGet - string.len(payload)
                 file.open(url, "a+")
                 file.write(payload)            
                 file.close() 
             else
                 sck:send("HTTP/1.1 200 OK\r\n\r\nERROR")
                 Status = 0
             end
 
             if DataToGet == 0 then
                 sck:send("HTTP/1.1 200 OK\r\n\r\nOK")
                 Status = 0
             end
         end
         
         return
     end
     -- end of POST method handling
     
     DataToGet = -1
     
     if url == "favicon.ico" then
         sck:send("HTTP/1.1 404 file not found\r\nServer: NodeMCU IDE\r\nContent-Type: text/html\r\n\r\n<html><head><title>404 - File Not Found</title></head><body>Ya done goofed.</body></html>")
         return
     end    
 
     local sen = "HTTP/1.1 200 OK\r\nServer: NodeMCU IDE\r\nContent-Type: text/html\r\nPragma: no-cache\r\nCache-Control: no-cache\r\n\r\n"
     
     -- it wants a file in particular
     if url ~= "" and vars == "" then
         DataToGet = 0
         sck:send(sen)
         return
     end
 
         sen = sen .. "<html><head><title>NodeMCU IDE</title><meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0\"><meta http-equiv=\"Expires\" content=\"-1\" />"
         sen = sen .. "<style>a:link{color:white;} a:visited{color:white;} a:hover{color:yellow;} a:active{color:green;}</style></head>"
         sen = sen .. "<body style=\"background-color:#333333;color:#dddddd\"><h1><a href='/'>NodeMCU IDE</a></h1>"
     
     if vars == "edit" then
         if AceEnabled then
             local mode = 'ace/mode/'
             if url:match(".css") then mode = mode .. 'css'
             elseif url:match(".html") then mode = mode .. 'html'
             elseif url:match(".json") then mode = mode .. 'json'
             elseif url:match(".js") then mode = mode .. 'javascript'
             else mode = mode .. 'lua'
             end
             sen = sen .. "<style type='text/css'>#editor{width: 100%; height: 80%}</style><div id='editor'></div><script src='//rawgit.com/ajaxorg/ace-builds/master/src-min-noconflict/ace.js'></script>"
                 .. "<script>var e=ace.edit('editor');e.setTheme('ace/theme/monokai');e.getSession().setMode('"..mode.."');function getSource(){return e.getValue();};function setSource(s){e.setValue(s);}</script>"
         else
             sen = sen .. "<textarea name=t cols=79 rows=17></textarea></br>"
                 .. "<script>function getSource() {return document.getElementsByName('t')[0].value;};function setSource(s) {document.getElementsByName('t')[0].value = s;};</script>"
         end
         sen = sen .. "<script>function tag(c){document.getElementsByTagName('w')[0].innerHTML=c};var x=new XMLHttpRequest();x.onreadystatechange=function(){if(x.readyState==4) setSource(x.responseText);};"
       .. "x.open('GET',location.pathname);x.send()</script><button onclick=\"tag('Saving, wait!');x.open('POST',location.pathname);x.onreadystatechange=function(){console.log(x.readyState);"
       .. "if(x.readyState==4) tag(x.responseText);};x.send(new Blob([getSource()],{type:'text/plain'}));\">Save</button> <a href='?run'>[Run File]</a> <a href=\"/\">[Main Page]</a> <w></w>"
 
     elseif vars == "run" then
         sen = sen .. "Output of the run:<hr><pre>"
 
         function s_output(str) sen = sen .. str end
         node.output(s_output, 0) -- re-direct output to function s_output.
 
         local st, result = pcall(dofile, url)

         -- delay the output capture by 1000 milliseconds to give some time to the user routine in pcall()
--         tmr.alarm(0, 1000, tmr.ALARM_SINGLE, function() 
             local ztmr_web_ide1 = tmr.create()
             ztmr_web_ide1:alarm(1000, tmr.ALARM_SINGLE, function()             
             ztmr_web_ide1=nil   node.output(nil)
             if result then
                 local outp = tostring(result):sub(1,1300) -- to fit in one send() packet
                 result = nil
                 sen = sen .. outp
             end
             sen = sen .. "</pre><hr><a href=\"?edit\">[Edit File]</a> <a href=\"?run\">[Run Again]</a> <a href=\"/\">[Main Page]</a></body></html>"
             sck:send(sen)
         end)
 
         return

     elseif vars == "rename" then
         file.rename(url:match("(.+)\/"), url:match("\/(.+)"))
         url = ""
 
     elseif vars == "compile" then
         collectgarbage()
         node.compile(url)
         url = ""
 
     elseif vars == "delete" then
         file.remove(url)
         url = ""
 
     elseif vars == "restart" then
         node.restart()
         return
 
     end
 
     local message = {}
     message[#message + 1] = sen
     sen = nil
     if url == "" then
         local l = file.list();
         message[#message + 1] = "<table border=1 cellpadding=3><tr><th>Name</th><th>Size</th><th>Edit</th><th>Rename</th><th>Compile</th><th>Delete</th><th>Run</th></tr>\n"
         for k,v in pairs(l) do
             local line = "<tr><td><a href='" ..k.. "'>" ..k.. "</a></td><td>" ..v.. "</td><td>"
             local editable = k:sub(-4, -1) == ".lua" or k:sub(-4, -1) == ".css" or k:sub(-5, -1) == ".html" or k:sub(-5, -1) == ".json" or k:sub(-4, -1) == ".txt" or k:sub(-4, -1) == ".csv"
             if editable then
                 line = line .. "<a href='" ..k.. "?edit'>edit</a>"
             end
             line = line .. "</td><td><a href='#' onclick='v=prompt(\"Type the new filename\");if (v!=null) { this.href=\"/"..k.."/\"+v+\"?rename\"; return true;} else return false;'>rename</a></td><td>"
             if k:sub(-4, -1) == ".lua" then
                 line = line .. "<a href='" ..k.. "?compile'>compile</a>"
             end
             line = line .. "</td><td><a href='#' onclick='v=prompt(\"Type YES to confirm file deletion!\");if (v==\"YES\") { this.href=\"/"..k.."?delete\"; return true;} else return false;'>delete</a></td><td>"
             if ((k:sub(-4, -1) == ".lua") or (k:sub(-3, -1) == ".lc")) then
                 line = line .. "<a href='" ..k.. "?run'>run</a></td></tr>\n"
             end
             message[#message + 1] = line
         end
         remaining, used, total=file.fsinfo()
         message[#message + 1] = "</table><br>Total: "..total.." Bytes <br> Used: "..used.." Bytes <br> Remaining: "..remaining.." Bytes <br><br><a href='#' onclick='v=prompt(\"Filename\");if (v!=null) { this.href=\"/\"+v+\"?edit\"; return true;} else return false;'>[New File]</a>&nbsp;"
         remaining, used, total=nil
       message[#message + 1] = "<a href='#' onclick='var x=new XMLHttpRequest();x.open(\"GET\",\"/?restart\");x.send();setTimeout(function(){location.href=\"/\"},5000);this.innerText=\"[Please wait...]\";return false'>[Restart]</a>"
     end
     message[#message + 1] = "</body></html>"
 
     local function send_table(sk)
         if #message > 0 then
             sk:send(table.remove(message, 1))
         else
             sk:close()
             message = nil
         end
     end
     sck:on("sent", send_table)
         send_table(sck)
     end)
 
   conn:on("sent", function(sck)
     if DataToGet >= 0 and method == "GET" then
         if file.open(url, "r") then
             file.seek("set", DataToGet)
             local chunkSize = 512
             local line = file.read(chunkSize)
             file.close()
             if line then
                 sck:send(line)
                 DataToGet = DataToGet + chunkSize
                 if string.len(line) == chunkSize then return end
             end
         end        
     end
 
     sck:close()
     sck = nil
   end)
  end)
end
 
local ztmr_web_ide2 = tmr.create()
ztmr_web_ide2:alarm(500, tmr.ALARM_AUTO, function()
if (wifi.sta.status() == wifi.STA_GOTIP) then
    ztmr_web_ide2:unregister()   ztmr_web_ide2=nil
    print("\n--- Web server started ---")
    print("NodeMCU Web IDE running at http://"..wifi.sta.getip()..":"..mPort.."/")
    editor()
end
end)
