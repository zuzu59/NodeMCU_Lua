-- Petit script pour envoyer quelque chose sur un serveur WEB
print("\n web_cli.lua   zf181011.2352   \n")

function disp_send()
--    http.get("http://192.168.4.1/?line1="..zlength.."m", nil, function(code, data)
    print("web_cli: "..zled_state)
    http.get("http://192.168.0.122/?pin="..zled_state, nil, function(code, data)
        if (code < 0) then
          print("HTTP request failed")
        else
          print(code, data)
        end
    end)
end
