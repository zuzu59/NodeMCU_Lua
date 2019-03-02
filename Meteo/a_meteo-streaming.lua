-- Script pour aller chercher les prévision de la pluie pour une ville sur Internet
-- Permet de ne prendre que ce qui est nécéssaire dans un grand flux JSON
-- affiche de https://www.prevision-meteo.ch/services/json/lausanne
-- les conditions pour toutes les heures la journée
-- Source: https://github.com/nodemcu/nodemcu-firmware/blob/master/lua_examples/sjson-streaming.lua

print("\n a_meteo-streaming.lua zf190302.1931 \n")

local s = tls.createConnection()
s:on("connection", function(sck, c)
--  sck:send("GET /services/json/lausanne HTTP/1.0\r\nUser-agent: nodemcu/0.1\r\nHost: www.prevision-meteo.ch\r\nConnection: close\r\nAccept: application/json\r\n\r\n")
  sck:send("GET /services/json/lausanne HTTP/1.0\r\nHost: www.prevision-meteo.ch\r\n\r\n")
end)

function startswith(String, Start)
  return string.sub(String, 1, string.len(Start)) == Start
end

local seenBlank = false
local partial
--local wantval = { tree = 1, path = 1, url = 1 }
local wantval = { fcst_day_0 = 1, hourly_data = 1, CONDITION_KEY = 1 }
-- Make an sjson decoder that only keeps certain fields
local decoder = sjson.decoder({
  metatable =
  {
    __newindex = function(t, k, v)
      if wantval[k] or type(k) == "number" then
        rawset(t, k, v)
      end
    end
  }
})
local function handledata(s)
  decoder:write(s)
end

-- The receive callback is somewhat gnarly as it has to deal with find the end of the header
-- and having the newline sequence split across packets
s:on("receive", function(sck, c)
print(c)
  if partial then
    c = partial .. c
    partial = nil
  end
  if seenBlank then
    handledata(c)
    return
  end
  while c do
    if startswith(c, "\r\n") then
      seenBlank = true
      c = c:sub(3)
      handledata(c)
      return
    end
    local s, e = c:find("\r\n")
    if s then
      -- Throw away line
      c = c:sub(e + 1)
    else
      partial = c
      c = nil
    end
  end
end)

local function getresult()
  local result = decoder:result()
  -- This gets the resulting decoded object with only the required fields
--local wantval = { fcst_day_0 = 1, hourly_data = 1, condition_key = 1 }

-- le 4e champs
print(result['fcst_day_0'][4]['hourly_data'], "is at", result['fcst_day_0'][4]['CONDITION_KEY'])
-- le 16e champs
print(result['fcst_day_0'][16]['hourly_data'], "is at", result['fcst_day_0'][16]['conditCONDITION_KEYion_key'])
  print(node.heap())
end

s:on("disconnection", getresult)
s:on("reconnection", getresult)

-- Make it all happen!
s:connect(443, "www.prevision-meteo.ch")

