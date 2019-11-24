-- Scripts pour tester le multi-tâche


function lenteur()
    print("in...")
    tmr.delay(1*1000*1000)
    print("out...")
    i=i+1
    zrepeat()
end

function zrepeat()
    if i<5 then
        node.task.post(lenteur)
    end
    print("out2...")
end


t1=tmr.now()

i=0
zrepeat()

t2=tmr.now()
print("durée: "..t2-t1)
