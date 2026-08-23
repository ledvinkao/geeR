# Nahrání vlastního snímku -----------------------------------------------

# také snímky (nebo obecněji rastrové objekty) lze na GEE nahrávat programaticky
# postupujeme velmi obdobně jako ve skriptu 05, jen využijeme jinou funkci
# konkrétně zde potřebujeme funkci raster_as_ee() nebo funkci stars_as_ee()

# načtěme potřebné balíčky
xfun::pkg_attach2(
  "tidyverse",
  "terra",
  "stars",
  "rgee"
)

# inicializujeme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz",
  gcs = T # bohužel iniciace procesu přes Google Cloud Storage (gcs) je nutností pro fungování, což nemusí jít pod každým účtem, nemá-li ověřenou kreditní nebo debetní kartu
)

# pokud nahrajeme více snímků, které budou na sebe geometricky sedět, lze dostat ImageCollection
# abychom nenahrávali snímky po jednom, je vhodné se zaměřit na mapování nahrávacích funkcí
# aby ImageCollection bylo možné korektně filtrovat, je vhodné ji nastavit metadata

# blíže k programatickému nahrávání snímků viz
?raster_as_ee

# nebo
?stars_as_ee
