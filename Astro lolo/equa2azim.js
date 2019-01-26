// script en JS pour calculer les coordonnées longitude/azimut depuis une coordonnée équatoriale
// le but du jeu c'est de convertir ce script JS en Lua pour le NodeMCU avec asservissement d'un
// télescope à monture azimutale
// zf180807.2217
// source https://astronomy.stackexchange.com/questions/15013/calculating-azimuth-from-equatorial-coordinates

// a=arctan2(sin(θ−α),sinφ∗cos(θ−α)−cosφ∗tanδ)
// Where
// φ = geographic latitude of the observer (here: 0°)
// θ = sidereal time (here: 0°)
// δ = declination
// α = right ascension

obliq = deg2rad(23.44);  // obliquity of ecliptic
  lat2  = deg2rad(0);  // observer's latitude
  lmst  = deg2rad(0);  // siderial time

  function equatorial(lat, lon) {
    // returns equatorial from ecliptic coordinates
    dec = Math.asin( Math.cos(obliq) * Math.sin(lat) + Math.sin(obliq) *
          Math.cos(lat) * Math.sin(lon));
    ra  = Math.atan2(Math.cos(obliq) * Math.sin(lon) - Math.sin(obliq) * Math.tan(lat),
          Math.cos(lon));
    ra += 2 * Math.PI * (ra < 0);
    return [dec, ra];
  }

  function horizontal(lat, lon) {
    // returns horizontal from ecliptic coordinates
    coords = equatorial(lat, lon);
    dec = coords[0];  // δ
    ra  = coords[1];  // α
    alt = Math.asin(Math.sin(lat2) * Math.sin(dec) + Math.cos(lat2) *
          Math.cos(dec) * Math.cos(lmst - ra));
    azm = Math.atan2(Math.sin(lmst - ra), Math.sin(lat2) * Math.cos(lmst - ra) -
          Math.cos(lat2) * Math.tan(dec));
    azm += 2 * Math.PI * (azm < 0);
    return [alt, azm];
  }
