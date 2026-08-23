# Odkázání se na kolekci snímků ------------------------------------------

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# inicializujeme připojení
ee_Initialize(user = "ledvinka@natur.cuni.cz")

# odkážeme se na kolekci snímků (ImageCollection)
# textové řetězce ve funkci lze kopírovat z Datového katalogu GEE, není třeba si je mapatovat
coll <- ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED")
