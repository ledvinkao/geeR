
# Filtrování kolekce snímků podle prostorové příslušnosti ----------------

# velmi užitečné je filtrování kolekcí podle jejich reprezentace zájmové oblasti
# zaměříme se tím mnohem blíže na místo našeho zájmu na Zemi, ale také tím urychlíme následující výpočty

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# zaměříme se např. na snímky mise Sentinel-1
# a ještě schválně specifikujeme první polovinu roku 2026
col <- 
  ee$ImageCollection("COPERNICUS/S1_GRD")

# řekněme, že po stránce místa budeme chtít pracovat je se snímky, které překrývají astronomický střed Evropy
pt <- 
  ee$Geometry$Point(15, 50)

# a nyní filtrujeme
# filtry se dají kombinovat
# jako bychom řetězili pomocí pipů v R, ale zde namísto nich používáme znak $
col2 <- col$filterDate("2026-01-01", "2026-07-01")$filterBounds(pt)

# a prohlédneme např. metadata
col2 |> 
  ee_print()

# za povšimnutí stojí, že crs není třeba dávat do souladu
# GEE si vše vyřeší sám
