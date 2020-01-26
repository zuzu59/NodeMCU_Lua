-- Petit script pour envoyer les valeurs de température sur un serveur WEB via un HTTP GET

function send_data()
    if verbose then print("\n 0_send_data.lua   zf200119.1518   \n") end

    if verbose then print("send_data_web: ") end
    if verbose then print(zurl) end

    http.get(zurl, nil, function(code, data)
            if (code < 0) then
                if verbose then print("HTTP request failed") end
                if verbose then print("zuzu", code, data) end
            else
                if verbose then print(code, data) end
            end
            zurl=nil
        end)
    zurl=nil send_data=nil
    if verbose then print(node.heap()) end
    collectgarbage()
    if verbose then print(node.heap()) end
end

send_data()
