# Tranfer GEE vektorové vrstvy do lokální stanice ------------------------

# někdy se potřebujeme s výsledným výběrem vrátit do lokálního zpracování
# umožní nám to např. můžeme ktreslit ve smyslu ggplot2

# načteme rgee a tidyverse
# rovněž tak si vezmeme na pomoc balíček sf
xfun::pkg_attach2(
  "tidyverse",
  "sf",
  "rgee"
)

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# pokračujme ve skriptu 18 s administrativním členěním Česka
adm <-
  ee$FeatureCollection(
    "FAO/GAUL/2015/level1"
  )$filter(ee$Filter$stringStartsWith("ADM0_NAME", "Czech"))

cesko <-
  adm |>
  ee_as_sf()

# nyní můžeme kreslit tuto lokálně uloženou vrstvu
# a zjistit, oč vlastně jde
ggplot() +
  geom_sf(data = cesko)

# z toho plyne ponaučení, že věřit bychom měli spíše vlastním vektorovým vrstvám
