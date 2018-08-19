-- script en LUA pour calculer les coordonnées horizontales (hauteur/azimut) depuis une coordonnée équatoriale
-- pour en faire un asservissement d'un télescope à monture azimutale.
-- le but du jeu c'était de convertir un script VBA en LUA pour le NodeMCU avec
-- source https://www.webastro.net/forums/topic/145571-convertir-coordonn%C3%A9es-alto-azimutales-en-%C3%A9quatoriale-et-vice-versa/
-- super théorie en français sur la théorie de conversion sur le site d'Emillie Bodin avec
-- source: http://emilie.bodin.free.fr/logiciel/logicielframe.html

-- le problème avec le LUA embarqué sur NodeMCU c'est qu'il n'y a pas de fonctions trigo :-(
-- zf180815.2226


-- latitude/longitude de l'observateur à Crissier/VD/CH
Lat_h = 46   Lat_m = 32   Lat_s = 32
Long_h = 6   Long_m = 34   Long_s = 29
-- date et heure locale de l'observation
Dayz = 13   Monthz = 8   Yearz = 2018
Hourz = 22   Minutez = 0   Secondz = 0
-- time Zone
Zone = 2

-- données pour Crissier/VD/CH le 13 août 2018 à 22h00 de Saturne
-- ascension droite et déclinaison (depuis les éphémérides) de la coordonnée équatoriale
AD_h = 18   AD_m = 12   AD_s = 56
Dec_minus = -1 Dec_h = 22   Dec_m = 38   Dec_s = 34
-- hauteur et azimut (depuis les éphémérides) de la coordonnée horizontale
Haut_h = 20   Haut_m = 44   Haut_s = 14
Azmt_h = 175   Azmt_m = 36   Azmt_s = 21

--[[
-- données pour Crissier/VD/CH le 13 août 2018 à 22h00 de Altaïr
-- ascension droite et déclinaison (depuis les éphémérides) de la coordonnée équatoriale
AD_h = 19   AD_m = 51   AD_s = 42
Dec_minus = 1 Dec_h = 8   Dec_m = 55   Dec_s = 07
-- hauteur et azimut (depuis les éphémérides) de la coordonnée horizontale
Haut_h = 44   Haut_m = 55   Haut_s = 14
Azmt_h = 137   Azmt_m = 12   Azmt_s = 24
]]


-- conversions diverses
PI = math.pi
bool_to_number={ [true]=1, [false]=0 }
Latitude = Lat_h + Lat_m / 60 + Lat_s / 3600
Longitude = Long_h + Long_m / 60 + Long_s / 3600
AD = AD_h + AD_m / 60 + AD_s / 3600
Dec = Dec_minus * (Dec_h + Dec_m / 60 + Dec_s / 3600)
Hauteur = Haut_h + Haut_m / 60 + Haut_s / 3600
Azimuth = Azmt_h + Azmt_m / 60 + Azmt_s / 3600

function fAngle_horaire()
  AD_in_degre = 15 * AD
  if Monthz < 3 then Monthz = Monthz + 12   Yearz = Yearz - 1 end
  A = math.floor(Yearz / 100)   B = 2 - A + math.floor(A / 4)
  C = math.floor(365.25 * Yearz)   D = math.floor(30.6001 * (Monthz + 1))
  JJ = B + C + D + Dayz + 1720994.5   T = (JJ - 2451545) / 36525
  H1 = 24110.54841 + (8640184.812866 * T) + (0.093104 * (T * T)) - (0.0000062 * (T * T * T))
  HSH = H1 / 3600   HS = ((HSH / 24) - math.floor(HSH / 24)) * 24
  AngleH = (2 * PI * HS / (23 + 56 / 60 + 4 / 3600)) * 180 / PI
  AngleT = ((Hourz - 12 + Minutez / 60 - Zone) * 2 * PI / (23 + 56 / 60 + 4 / 3600)) * 180 / PI
  Angle_horaire = AngleH + AngleT - AD_in_degre + Longitude
end

function fHauteur()
  Sin_hauteur = math.sin(Dec * PI / 180) * math.sin(Latitude * PI / 180) - math.cos(Dec * PI / 180) * math.cos(Latitude * PI / 180) * math.cos(Angle_horaire * PI / 180)
  Hauteur = math.asin(Sin_hauteur) * 180 / PI
end

function fAzimuth()
  Cosazimuth = (math.sin(Dec * PI / 180) - math.sin(Latitude * PI / 180) * math.sin(Hauteur * PI / 180)) / (math.cos(Latitude * PI / 180) * math.cos(Hauteur * PI / 180))
  Sinazimuth = (math.cos(Dec * PI / 180) * math.sin(Angle_horaire * PI / 180)) / math.cos(Hauteur * PI / 180)
  if (Sinazimuth > 0) then Az = math.acos(Cosazimuth) * 180 / PI else Az = -math.acos(Cosazimuth) * 180 / PI end
  if (Az < 0) then Azimuth = 360 + Az else Azimuth = Az end
end


print "\ntoto"
print("Ephémérides\nHauteur: "..Hauteur..", Azimuth: "..Azimuth)
fAngle_horaire()
--print("Heure sidérale: "..HS..", Angle horaire: "..Angle_horaire)
fHauteur()
fAzimuth()
print("Calculée\nHauteur: "..Hauteur..", Azimuth: "..Azimuth)









--[[code en VBA https://www.webastro.net/forums/topic/145571-convertir-coordonn%C3%A9es-alto-azimutales-en-%C3%A9quatoriale-et-vice-versa/
L'angle horaire a comme argument
- l'AD
- la Longitude
- la date
- L'Heure (pas TU, l'heure de la montre)
- la Zone géographique (2 en été pour la France, 1 pour l'hiver)

La hauteur est donnée par la fonction "Hauteur" qui a comme arguments:
- la Déc
- la latitude
- l'angle horaire

L'azimuth est donnée par la fonction "Azimuth" qui a comme arguments:
- La Déc
- la latitude
- l'angle horaire
- La hateur calculée précédemment


Function Angle_horaire(AD As Date, Longitude As Single, Date_choisie As Date, Heure_choisie As Date, Zone As Integer) As Single
  Dim Dayz, Monthz, Yearz, Hourz, Minutez, Secondz As Integer
  Dim AD_in_degre, A, B, C, D, JJ, T, H1, HSH, HS, AngleH, AngleT, PI As Single

  PI = 3.14159
  Dayz = Day(Date_choisie)
  Monthz = Month(Date_choisie)
  Yearz = Year(Date_choisie)
  Hourz = Hour(Heure_choisie)
  Minutez = Minute(Heure_choisie)
  Secondz = Second(Heure_choisie)

  AD_in_degre = 15 * (Hour(AD) + Minute(AD) / 60 + Second(AD) / 3600)
  If (Monthz < 3) Then
    Monthz = Monthz + 12
    Yearz = Yearz - 1
  End If
  A = Int(Yearz / 100)
  B = 2 - A + Int(A / 4)
  C = Int(365.25 * Yearz)
  D = Int(30.6001 * (Monthz + 1))
  JJ = B + C + D + Dayz + 1720994.5
  T = (JJ - 2451545) / 36525
  H1 = 24110.54841 + (8640184.812866 * T) + (0.093104 * (T * T)) - (0.0000062 * (T * T * T))
  HSH = H1 / 3600
  HS = ((HSH / 24) - Int(HSH / 24)) * 24
  AngleH = (2 * PI * HS / (23 + 56 / 60 + 4 / 3600)) * 180 / PI
  AngleT = ((Hourz - 12 + Minutez / 60 - Zone) * 2 * PI / (23 + 56 / 60 + 4 / 3600)) * 180 / PI
  Angle_horaire = AngleH + AngleT - AD_in_degre + Longitude
End Function

Function Convert_temps(ByVal T As Single) As String
  Dim H, M, S As Integer
  Dim Temp, Temp2 As Single

  H = Int(T)
  If H >= 24 Then H = H - 24
  Temp = T - H
  Temp2 = Temp * 60
  M = Int(Temp2)
  If M >= 60 Then
    M = 0
    H = H + 1
  End If
  Temp = Temp - M / 60
  Temp2 = Temp * 3600
  S = Temp2
  If S >= 60 Then
    S = 0
    M = M + 1
  End If
  Convert_temps = H & ":" & M & ":" & S
End Function

Function Arsin(ByVal X As Single) As Single
  If (Abs(X) >= 1) Then Arsin = 0 Else Arsin = Atn(X / Sqr(-X * X + 1))
End Function

Function Arcos(ByVal X As Single) As Single
  If (Abs(X) >= 1) Then Arcos = 0 Else Arcos = Atn(-X / Sqr(-X * X + 1)) + 2 * Atn(1)
End Function

Function Hauteur(Dec As Single, Latitude As Single, H As Single) As Single
  Dim Sin_hauteur, PI As Single

  PI = 3.14159
  Sin_hauteur = Sin(Dec * PI / 180) * Sin(Latitude * PI / 180) - Cos(Dec * PI / 180) * Cos(Latitude * PI / 180) * Cos(H * PI / 180)
  Hauteur = Arsin(Sin_hauteur) * 180 / PI
End Function

Function Azimuth(Dec As Single, Lat As Single, H As Single, Haut As Single) As Single
  Dim Cosazimuth, Sinazimuth, test, Az As Single

  PI = 3.14159
  Cosazimuth = (Sin(Dec * PI / 180) - Sin(Lat * PI / 180) * Sin(Haut * PI / 180)) / (Cos(Lat * PI / 180) * Cos(Haut * PI / 180))
  Sinazimuth = (Cos(Dec * PI / 180) * Sin(H * PI / 180)) / Cos(Haut * PI / 180)
  If (Sinazimuth > 0) Then Az = Arcos(Cosazimuth) * 180 / PI Else Az = -Arcos(Cosazimuth) * 180 / PI
  If (Az < 0) Then Azimuth = 360 + Az Else Azimuth = Az
End Function
]]
