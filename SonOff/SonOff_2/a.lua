print('\\n-----')
local l = file.list()
table.sort(l)
for k,v in pairs(l) do print(k..', size:'..v)end
print('-----\\n')


zdir={};pfile = file.list();for k,v in pairs(pfile) do zdir[#zdir+1] = k..string.rep(" ",24-string.len(k)).." : "..v end;table.sort(zdir);print('\n-----');for i=1, #zdir do print(zdir[i]) end;print('-----\n');zdir=nil;pfile=nil;k=nil;v=nil;i=nil

