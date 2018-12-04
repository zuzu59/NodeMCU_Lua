-- pour effacer TOUS les fichiers qui se trouve dans la flash du NodeMCU

print("\n rm_files.lua zf180907.1511 \n")


l=file.list() i=0
for k,v in pairs(l) do
    i=i+v
    file.remove(k)
end
print("-------------------------------")
print("\nC'est tout effaced :-) \n")
