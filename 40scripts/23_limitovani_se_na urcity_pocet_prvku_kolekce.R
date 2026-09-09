# Limitování se na určitý počet prvků kolekce ----------------------------

# již jsme probrali servrovou funkci first(), kterou aplikujeme na kolekci
# ale, když potřebujeme prvních n prvků kolekce, tato funkce nepomůže
# existuje proto také serverová funkce limit()
# tato funkce akceptuje také řazení podle nějakých vlastností prvků kolekce

# demonstrujme řečené na kolekci snímků, která vzniká ve skriptu 19

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# napojme se na kolekci a hned filtrujme
col <-
  ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED")$filterDate(
    "2022-07-01",
    "2026-08-01"
  )$filterBounds(ee$Geometry$Point(
    15,
    50
  ))$filter(ee$Filter$calendarRange(7, 7, "month"))

# nyní se např. budeme chtít zaměřit na prvních pět snímků s nejmenším procentem oblačnosti
col2 <-
  col$limit(5, "CLOUDY_PIXEL_PERCENTAGE")

# skutečně máme nyní v kolekci jen pět snímků
col2$size()$getInfo()
