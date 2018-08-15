-- script en LUA pour calculer les coordonnées horizontale (hauteur/azimut) depuis une coordonnée équatoriale
-- le but du jeu c'était de convertir script JS en LUA pour le NodeMCU avec asservissement d'un
-- télescope à monture azimutale.
-- le problème avec le LUA embarqué sur NodeMCU c'est qu'il n'y a pas de fonctions trigo :-(
-- zf180814.0753
-- source: https://astronomy.stackexchange.com/questions/15013/calculating-azimuth-from-equatorial-coordinates
-- source: https://www.webastro.net/forums/topic/145571-convertir-coordonn%C3%A9es-alto-azimutales-en-%C3%A9quatoriale-et-vice-versa/


-- ce n'est pas terminé !


--[[ ancien code en js https:astronomy.stackexchange.com/questions/15013/calculating-azimuth-from-equatorial-coordinates
	a=arctan2(sin(θ−α),sinφ∗cos(θ−α)−cosφ∗tanδ)
Where
	φ = geographic latitude of the observer (here: 0°)
	θ = sidereal time (here: 0°)
	δ = declination
	α = right ascension

obliq = math.rad(23.44)  -- obliquity of ecliptic
lat2  = math.rad(0)  -- observer's latitude
lmst  = math.rad(0)  -- siderial time

function equatorial(lat, lon)
  -- returns equatorial from ecliptic coordinates
  dec = math.asin( math.cos(obliq) * math.sin(lat) + math.sin(obliq) * math.cos(lat) * math.sin(lon))
  ra  = math.atan2(math.cos(obliq) * math.sin(lon) - math.sin(obliq) * math.tan(lat) , math.cos(lon))
  ra = ra + 2 * math.pi * bool_to_number[ra < 0]
  return dec, ra
end
]]



lat = math.rad(46.52)  -- latitude de l'observateur
long = math.rad(6.55)  -- longitude de l'observateur
timsid = math.rad((11+39/60+22/3600)*15)  -- 10h39mn22s temps sidérale de l'observateur

ra = math.rad(18+12/60+56/3600)   -- 18h12mn56, -22o38'34 ascension droite de la coordonnée équatoriale de l'objet céleste
dec = math.rad(-(22+38/60+34/3600))  -- -22o38'34 déclinaison de la coordonnée équatoriale de l'objet céleste

haut = math.rad(20+45/60)  -- +20o45 hauteur de la coordonnée horizontale du télescope
azmt = math.rad(175+35/60)  -- +175o35 azimut de la coordonnée horizontale du télescope

bool_to_number={ [true]=1, [false]=0 }


--[[ code en VBA https://www.webastro.net/forums/topic/145571-convertir-coordonn%C3%A9es-alto-azimutales-en-%C3%A9quatoriale-et-vice-versa/
Function Arsin(ByVal X As Single) As Single
	If (Abs(X) >= 1) Then Arsin = 0 Else Arsin = Atn(X / Sqr(-X * X + 1))
End Function

Function Arcos(ByVal X As Single) As Single
	If (Abs(X) >= 1) Then Arcos = 0 Else Arcos = Atn(-X / Sqr(-X * X + 1)) + 2 * Atn(1)
End Function

Function Hauteur(Dec As Single, Latitude As Single, H As Single) As Single
	Dim Sin_hauteur, PI As Single
	PI = 3.14159
	Sin_hauteur = Sin(Dec) * Sin(Latitude) - Cos(Dec) * Cos(Latitude) * Cos(H)
	Hauteur = Arsin(Sin_hauteur) * 180 / PI
End Function

Function Azimuth(Dec As Single, Lat As Single, H As Single, Haut As Single) As Single
	Dim Cosazimuth, Sinazimuth, test, Az As Single
	PI = 3.14159
	Cosazimuth = (Sin(Dec) - Sin(Lat) * Sin(Haut)) / (Cos(Lat) * Cos(Haut))
	Sinazimuth = (Cos(Dec) * Sin(H)) / Cos(Haut)
	If (Sinazimuth > 0) Then Az = Arcos(Cosazimuth) * 180 / PI Else Az = -Arcos(Cosazimuth) * 180 / PI
	If (Az < 0) Then Azimuth = 360 + Az Else Azimuth = Az
End Function
]]

function horizontal()  -- returns horizontal from equatorial coordinates
  haut = math.asin(math.sin(dec) * math.sin(lat)  - math.cos(dec) * math.cos(lat) * math.cos(timsid))
  azmt = math.atan2(math.sin(timsid - ra), math.sin(lat) * math.cos(timsid - ra) - math.cos(lat) * math.tan(dec))
  azmt = azmt + 2 * math.pi * bool_to_number[azmt < 0]
end



print "toto"
print(math.deg(haut),math.deg(azmt))
horizontal()
print(math.deg(haut),math.deg(azmt))
