
# Kompozity radarových geodat --------------------------------------------

# radary nesnímají povrch jako optické snímače
# proto nabízejí mnohem chudší kompinace kompozitů
# nicméně některé kompozity radarových geodat se mohou hodit

# načteme balíčky pro další práci
xfun::pkg_attach2(
  "tidyverse",
  "tidyrgee"
)

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz",
  drive = T
)

# založíme si zájmový bod
# není třeba tvořit polygon kolem něj (např. bufferem)
# filterBounds() pak vybere všechny snímky, kde dochází k překryvu s bodem
pt <- ee$Geometry$Point(15, 50)

# provedeme filtrování a vývěry
img <- 
  ee$ImageCollection("COPERNICUS/S1_GRD")$
  filterDate("2026-01-01", "2026-07-01")$
  filterBounds(pt)$
  filter(ee$Filter$eq("orbitProperties_pass", "DESCENDING"))$
  filter(ee$Filter$eq("instrumentMode", "IW"))$
  select("VV", "VH")$
  first()

# pro kompozity se konstruují diference nebo poměry VV a VH pásem
diference <- 
  img$select("VV")$
  subtract(img$select("VH"))$
  rename("diference") # nastavíme si vlastní název nového pásma

# přidáme diference k původnímu snímku
img2 <- 
  img$addBands(diference)

# bylo pásmo přidáno správně?
ee_print(img2)

# nastavme pro následující kreslení barevnou paletu
visParamsRGB <- list(
  min = c(-18, -25, 1), 
  max = c(0, -5, 15)
)

# centrujeme na bod a vybíráme úroveň zoomu
Map$centerObject(pt, 9)

# a kreslíme
Map$addLayer(
  img2, 
  visParamsRGB, 
  'Sentinel-1 RGB kompozit'
)
