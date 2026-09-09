# Filtr kolekcí zohledňující pravidelnost období -------------------------

# při různých aplikacích narážíme na problém výběru prvků kolekcí za stejné období napříč více roky
# řekněme, že nás např. zajímají optické snímky jenom každého měsíce července
# takové výběry se mohou hodit např. v lesnictví nebo zemědělství
# tento výběr (filtr) je usnadněn serverovou funkcí ee$Filter$calendarRange()

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# napojíme se např. na kolekci snímků mise Sentinel-2
col <-
  ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED")

# zkusme se zaměřit na července posledních pěti let
# a zároveň se zaměříme na snímky zahrnující astronomický střed Evropy
col2 <-
  col$filterDate("2022-07-01", "2026-08-01")$filterBounds(ee$Geometry$Point(
    15,
    50
  ))$filter(ee$Filter$calendarRange(7, 7, "month")) # číslem specifikujeme konkrétní měsíc a textově se odkážeme na období

# podmínky splňuje 150 snímků
# jak se mmůžeme snadno přesvědčit následujícím způsobem
col2$size()$getInfo()
