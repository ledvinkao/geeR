# Filtrování kolekcí podle metadat - alternativní způsob -----------------

# někomu se způsob filtrování pomocí serverové funkce filterMetadata() nemusí zamlouvat
# existuje i alternativní způsob, kde lze využít serverovou funkci ee$Filter uzavřenou v serverové funkci filter()
# zde se za názvem funkce pokračuje podle toho, zda potřebujeme rovnost (eq), ostrou nerovnost (gt / lt), nebo neostrou nerovnost (gte / lte)
# proveďme ekvivalentní filtrování k postupu uvedeném ve skriptu 15

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# vybereme opět kolekci snímků Sentinel-1 a rovnou filtrujeme na čas a místo
col <-
  ee$ImageCollection("COPERNICUS/S1_GRD")$filterDate(
    "2026-01-01",
    "2026-07-01"
  )$filterBounds(ee$Geometry$Point(15, 50))

# nyní se soustřeďme na filtrování podle metadat, jenom trochu jiným způsobem
col2 <-
  col$filter(ee$Filter$eq(
    "orbitProperties_pass",
    "DESCENDING"
  ))$filter(ee$Filter$eq(
    "instrumentMode",
    "IW"
  ))

# ověříme, zda filtry zafungovaly
col2$size()$getInfo()
