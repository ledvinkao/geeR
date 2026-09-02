# Vizualizace vektorových vrstev z GEE -----------------------------------

# GEE má chudší nabídku možností pro kreslení vektorových vrstev
# v tomto případě se napřed někdy využívá vykreslení prázdného snímku, na který se pak kreslí kýžená vrstva

# načteme balíček rgee
xfun::pkg_attach("rgee")

# zahájíme připojení
ee_Initialize(user = "ledvinka@natur.cuni.cz")

# využijeme např. administraivní členení zemí nabízené FAO
adm <- ee$FeatureCollection("FAO/GAUL/2015/level1")

# zaměříme se na Česko
# ale nejdříve musíme vědět, na základě jaké vlastnosti se můžeme omezovat na vybrané administrativní jednotky
adm$first()$propertyNames()$getInfo()

# je zde vhodný soupec 'ADM0_NAME'
# aplikujeme funkci s nápomocným filtrem
cesko <- adm$filter(
  ee$Filter$eq('ADM0_NAME', 'Czech Republic')
)

# nejprve prázdný snímek jako plátno
empty <- ee$Image()$byte()

# na něj pak nakreslíme vektorovou vrstvu (zde vybrané polygony)
slozenka <- empty$paint(
  featureCollection = cesko,
  color = 1,
  width = 1
)

# centrujeme na zájmovou oblast
# centrovat lze na objekt s geometrií (např. jeden z polygonů) nebo na souřadnice
Map$centerObject(cesko, 10)

# a konečne vizualizujeme v dynamické mapě
Map$addLayer(
  slozenka,
  list(palette = 'FF0000'),
  "Cesko adm1"
)
