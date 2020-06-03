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


--[[

t1={}
for k,v in pairs(pfile) do
    t1[#t1+1]=k
end

print(t1[3])


t1 = file.list()
print(file.list()["a.lua"])


print(file.list[1])
print(#file.list)



]]