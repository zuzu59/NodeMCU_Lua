-- Petit script pour envoyer quelque chose sur un serveur WEB
print("\n web_cli.lua   zf180828.1849   \n")

function disp_send()
--    http.get("http://192.168.4.1/?line1="..zlength.."m", nil, function(code, data)
print(zstate)
http.get("http://192.168.0.177/?pin="..zstate, nil, function(code, data)
        if (code < 0) then
--          print("HTTP request failed")
        else
--          print(code, data)
        end
    end)
end
