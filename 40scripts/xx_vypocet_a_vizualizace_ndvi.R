# Výpočet a vizualizace NDVI ---------------------------------------------

# NDVI je snad nejužívanějším spektrálním (vegetačním) indexem, který se v dálkovém průzkumu Země odvozuje z optických dat
# z toho důvodu také v GEE existuje funkce normalizedDifference(), který však obecně dokáže vypočítat i jiné indexy založené na normalizovaném rozdílu hodnot dvou pásem

# načteme balíček rgee
# k tomu pro demonstraci uklizených kolekcí snímků načteme i balíček tidyrgee a tidyverse
# může se to hodit při hledání dlaždic bezoblačného dne při mozaikování
xfun::pkg_attach2(
  "tidyverse",
  "rgee",
  "tidyrgee"
)

# zahájíme připojení
# každý bude mít svůj uživatelský účet
ee_Initialize(
  user = "ledvinka@natur.cuni.cz",
  drive = T # to jen, pokud očekáváme, že transfer výsledků půjde přes Google Drive
)

# demonstrujme výsledek na snímcích mise Sentinel-2
# konkrétně se podíváme na měsíc září 2024, kdy se v Česku a okolí odehrály významné povodně
# zaměříme se na bod reprezentující suchý poldr Wlodzienin v Polsku a jeho 30km okolí
# duvodem je zaměření se na snímky poblíž Krnovska, které bylo povodní velmi zasaženo
col <- 
  ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED")$
  filterBounds(ee$Geometry$Point(17.8276967, 50.1168703)$buffer(30000))$
  filter(ee$Filter$lt("CLOUDY_PIXEL_PERCENTAGE", 10))$
  filterDate("2024-09-01", "2024-10-01")

# prohlédneme kolekci jako uklizený objekt, ať máme lepší povědomí o datumech
meta <- tidyrgee::as_tidyee(col)

# musíme se dostat do tabulky v seznamu s názvem 'vrt'
meta |> 
  pluck("vrt")

# klidně si ještě odhnízdíme sloupec 'band_names', ať vidíme označení pásem
meta |> 
  pluck("vrt") |> 
  unnest(band_names)

# vidíme, že v omezené kolekci je hned několik dnů na výběr
# podívejme se např. na 18. září a všechny dostupné dlaždice mozaikujme
img <- 
  col$
  filterDate("2024-09-18", "2026-09-19")$
  mosaic()

# nyní můžeme pro takto vzniklý snímek aplikovat výpočet NDVI
# bez vnořené klientské funkce list() serverová funkce normalizedDifference() nefungovala, tak funkci list() vkládáme
# musíme si dát pozor s jakými produkty zrovna pracujeme, protože pro každou družicovou misi máme pásma uspořádaná jinak
# pro Sentinel-2 tedy platí, že červené pásmo viditelného spektra je reprezentováno pásmem B4
# blízké infračervené pásmo (NIR) je reprezentováno pásmem B8
ndvi <- img$normalizedDifference(list("B8", "B4"))

# před kreslením centrujeme na bod zájmu a použijeme např. úroveň zoomu 11
Map$centerObject(ee$Geometry$Point(17.8276967, 50.1168703), 11)

# místo funkce Map$centerObject() lze použít také funkci Map$setCenter(), která akceptuje souřadnice místo geometrického objektu

# a kreslíme (díky možnostem R balíčku balíčku mapview lze takto dynamicky)
# speciálně se ve funkci Map$addLayer() musíme postarat o správnou paletu barev
# vektor hexadecimálních kódů barev např. dostaneme od AI:-)
# posledním argumentem při kreslení je název vrstvy
Map$addLayer(
    ndvi,
    list(
      min = -1,
      max = 1,
      palette = c("#8c510a", "#d8b365", "#f6e8c3", "#c7eaea", "#80cdc1", "#01665e")
    ),
    "NDVI"
  )
