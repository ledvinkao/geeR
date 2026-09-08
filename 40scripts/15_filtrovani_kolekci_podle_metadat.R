
# Filtrování kolekcí podle metadat (vlastností) --------------------------

# filtrování může probíhat nejen podle datumu a času a / nebo podle místa zájmu
# kolekce snímků i vektorové kolekce (vektorové vrstvy) mají metadata
# jak se dostat k metadatům (názvů vlastností) jednotlivých prvků těchto kolekcí, jsme již ukázali ve skriptu 08
# na znalosti těchto tzv. vlastností lze stavět dále a zakládat ne nich další filtry

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# zkusme pracovat s kolekcí snímků Sentinel-1
# rovnou filtrujeme časově i místně
col <- 
  ee$ImageCollection("COPERNICUS/S1_GRD")$
  filterDate("2026-01-01", "2026-07-01")$
  filterBounds(ee$Geometry$Point(15, 50))

col |> 
  ee_print()

# řekněme, že se nyní potřebujeme omezit na metadata
# orbitProperties_pass == "DESCENDING"
# a instrumentMode == "IW"
# k těmto účelům poslouží např. funkce filterMetadata()
col2 <- 
  col$filterMetadata("orbitProperties_pass", "equals", "DESCENDING")$
  filterMetadata("instrumentMode", "equals", "IW")

# zafungovaly tyto filtry?
col$size()$getInfo()

col2$size()$getInfo()
