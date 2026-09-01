# Prohlížení metadat GEE objektů -----------------------------------------

# někdy se vyplatí prohlédnout si metadata GEE objektů
# už třeba jen proto, abychom zjistili, zda vše funguje
# ale i proto, abychom zjistili, na základě jakých metadat můžeme filtrovat

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# inicializujeme připojení
ee_Initialize(user = "ledvinka@natur.cuni.cz")

# demonstrujme nejprve s naší vektorovou vrstvou
stred <- ee$FeatureCollection(
  "projects/ee-ledvinka/assets/astronomicky_stred_evropy"
)

# zobrazme detaily o metadatech pomocí funkce ee_print()
ee_print(stred)

# ukažme ještě, že tato funkce pracuje i se snímky
img <- ee$Image("MERIT/DEM/v1_0_3")

ee_print(img)

# pořád ale neznáme např. názvy sloupců vektorové vrstvy
# jak tedy na ně?
<<<<<<< HEAD
vlastnosti <-
  stred$first()$propertyNames()$getInfo()
=======
>>>>>>> fa0c1a32beb37a8aed50483d97b561daddf8782d

stred$first()$propertyNames()$getInfo()

# strategicky vybíráme první (zde jediný řádek), abychom dostali názvy sloupců # tímto dostaneme vektor s názvy sloupců do prostředí R
