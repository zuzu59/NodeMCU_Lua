-- tests pour Maxime pour envoyer une valeur sur Thingspeak en pressant le bouton
-- ATTENTION: ce n'est pas testé
-- zf200131.1124


zBTN=3
gpio.mode(zBTN,gpio.INT)

d=tmr.now()

function maxime_send (a,b,c)
    if b-d > 300*1000 then
		ztemp1=ta valeur
		zhum1= une autre valeur
		thingspeak_url="http://api.thingspeak.com/update?api_key=kkk&"
		zurl = thingspeak_url.."field1="..tostring(ztemp1).."&field2="..tostring(zhum1)

		http.get(zurl, nil, function(code, data)
			if (code < 0) then
				if verbose then print("HTTP request failed") end
				if verbose then print("zuzu", code, data) end
			else
				if verbose then print(code, data) end
			end
		end)

        d=b
    end
end

gpio.trig(zBTN, "down", maxime_send)
