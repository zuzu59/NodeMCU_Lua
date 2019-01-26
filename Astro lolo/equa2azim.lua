-- script en LUA pour calculer les coordonnées longitude/azimut depuis une coordonnée équatoriale
-- le but du jeu c'était de convertir script JS en LUA pour le NodeMCU avec asservissement d'un
-- télescope à monture azimutale.
-- le problème avec le LUA embarqué sur NodeMCU c'est qu'il n'y a pas de fonctions trigo :-(
-- zf180807.2300
-- source https:--astronomy.stackexchange.com/questions/15013/calculating-azimuth-from-equatorial-coordinates


-- ce n'est pas terminé !


-- a=arctan2(sin(θ−α),sinφ∗cos(θ−α)−cosφ∗tanδ)
-- Where
-- φ = geographic latitude of the observer (here: 0°)
-- θ = sidereal time (here: 0°)
-- δ = declination
-- α = right ascension

obliq = math.rad(23.44)  -- obliquity of ecliptic
lat2  = math.rad(0)  -- observer's latitude
lmst  = math.rad(0)  -- siderial time

bool_to_number={ [true]=1, [false]=0 }

function equatorial(lat, lon)
  -- returns equatorial from ecliptic coordinates
  dec = math.asin( math.cos(obliq) * math.sin(lat) + math.sin(obliq) * math.cos(lat) * math.sin(lon))
  ra  = math.atan2(math.cos(obliq) * math.sin(lon) - math.sin(obliq) * math.tan(lat) , math.cos(lon))
  ra = ra + 2 * math.pi * bool_to_number[ra < 0]
  return dec, ra
end

function horizontal(lat, lon)
  -- returns horizontal from ecliptic coordinates
  coords = equatorial(lat, lon)
  dec = coords[0]  -- δ
  ra  = coords[1]  -- α
  alt = math.asin(math.sin(lat2) * math.sin(dec) + math.cos(lat2) * math.cos(dec) * math.cos(lmst - ra))
  azm = math.atan2(math.sin(lmst - ra), math.sin(lat2) * math.cos(lmst - ra) - math.cos(lat2) * math.tan(dec))
  azm = azm + 2 * math.pi * bool_to_number[azm < 0]
  return alt, azm
end



print "toto"

horizontal(13,6)
