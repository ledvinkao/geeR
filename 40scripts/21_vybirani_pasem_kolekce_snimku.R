# Výběr pásem kolekce snímků ---------------------------------------------

# optické satelitní snímky disponují několika pásmy
# často potřebujeme po další práci vybrat jen některé z nich
# řekněme, že pro výpočet známého indexu NDVI potřebujeme jen pásma B4 (red) a B8 (NIR) mise Sentinel-2

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# napojme se na kýženou kolekci snímků mise Sentinel-2
# zaměřme se např. jen na téměř bezoblačné snímky s období červen-srpen 2026
# omezme se také jen na snímky obsahující astronomický střed Evropy
col <-
  ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED")$filterDate(
    "2026-06-01",
    "2026-09-01"
  )$filterBounds(ee$Geometry$Point(15, 50))$filter(ee$Filter$lt(
    "CLOUDY_PIXEL_PERCENTAGE",
    10
  ))

# podívejme se nyní na metadata
col |>
  ee_print()

# skutečně zde stále máme pásma B4 a B8
# vyberme tedy jen je
# k výberu pásem slouží serverová funkce select()
col2 <-
  col$select("B4", "B8")

# jou vybraná už jen tato dvě pásma?
col2 |>
  ee_print()

# poznamenejme, že výběr pásem se dá aplikovat jak na ImageCollection tak na Image
# důležité je si uvědomit, že pokud se jedná o ImageCollection, není třeba funkci select() mapovat
# o mapování funkcí pojednávají pozdější skripty
