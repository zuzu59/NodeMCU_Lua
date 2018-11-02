-- httpserver-header.lua
-- Part of nodemcu-httpserver, knows how to send an HTTP header.
-- Author: Marcos Kirsch

return function (connection, code, extension, isGzipped)

   local function getHTTPStatusString(code)
      local codez = {[200]="OK", [304]="Not Modified", [400]="Bad Request", [404]="Not Found", [500]="Internal Server Error",}
      local myResult = codez[code]
      -- enforce returning valid http codes all the way throughout?
      if myResult then return myResult else return "Not Implemented" end
   end

   local function getMimeType(ext)
      -- A few MIME types. Keep list short. If you need something that is missing, let's add it.
      local mt = {css = "text/css", gif = "image/gif", html = "text/html", ico = "image/x-icon", jpeg = "image/jpeg", jpg = "image/jpeg", js = "application/javascript", json = "application/json", png = "image/png", xml = "text/xml", svg = "image/svg+xml"}
      if mt[ext] then return mt[ext] else return "text/plain" end
   end

   local mimeType = getMimeType(extension)

   connection:send("HTTP/1.0 " .. code .. " " .. getHTTPStatusString(code) .. "\r\nServer: nodemcu-httpserver\r\nContent-Type: " .. mimeType .. "\r\n")
   if isGzipped then
      connection:send("Cache-Control: max-age=2592000\r\nContent-Encoding: gzip\r\n")
      --TODO: handle Last-Modified for each file instead of use a fixed dummy date time
      connection:send("Last-Modified: Fri, 01 Jan 2016 00:00:00 GMT\r\n")
   else
      connection:send("Cache-Control: private, no-store\r\n")
   end
   connection:send("Connection: close\r\n\r\n")
end
