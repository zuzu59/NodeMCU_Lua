-- Permet de tester si une adresse IP est active
-- ATTENTION, ne fonctionne seulement s'il y a du réseau !

print("\n ping.lua   zf181113.1937   \n")

function Ping(mIP)
    t1=tmr.now()
    conn=net.createConnection(net.TCP, 0)
    conn:connect(1,mIP)
    conn:on("disconnection", function(sck, c)
        -- on disconnection
        t2 = tmr.now()
        t3=(t2-t1)/1000/1000
        print(t3)
            if ((t3)<5) then 
                --IPCount=IPCount+1 
                print(mIP.." is active.")
            else
                print(mIP.." is not active.")
            end
        t1, t2, t3 = nil
    end)
    sck, c, conn = nil
    collectgarbage()
end

Ping("192.168.0.102")


