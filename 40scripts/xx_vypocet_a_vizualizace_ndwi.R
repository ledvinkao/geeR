# Výpočet a vizualizace NDWI ---------------------------------------------

# ve skriptu xx jsme se zabývali výpočtem a vizualizací indexu NDVI
# zaměřili jsme se schválně na období s povodní a na misi Sentinel-2 s prostorovým rozlišením 10 m
# pro vizualizaci záplavových území se ale více hodí index NDWI (normaized difference water index)
# napodobme tvorbu mozaiky ze skriptu xx a vizualizujme namísto NDVI index NDWI

# načteme balíček rgee
xfun::pkg_attach2(
  "rgee"
)

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

img <- 
  ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED")$
  filterBounds(ee$Geometry$Point(17.8276967, 50.1168703)$buffer(30000))$
  filter(ee$Filter$lt("CLOUDY_PIXEL_PERCENTAGE", 10))$
  filterDate("2024-09-18", "2024-09-19")$
  mosaic()

# zde je pořadí viditelného (zeleného) pásma a NIR pásma obrácené
ndwi <- img$normalizedDifference(list("B3", "B8"))

# a kreslíme s nějakou nabídnutou paletou barev
Map$centerObject(ee$Geometry$Point(17.8276967, 50.1168703), 11)

# kvůli důrazu na vodu můžeme pozměnit minumum a maximum
Map$addLayer(
    ndwi,
    list(
      min = -0.1,
      max = 0.5,
      palette = c("#ece7f2", "#a6bddb", "#2b8cbe", "#045a8d")
    ),
    "NDWI"
  )
