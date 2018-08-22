--Pour arrêter le petit serveur WEB
print("\nzf20180718.1049")

srv:close()
srv:listen(80, function(conn)
end)

print("\nWEB stopped\n")
