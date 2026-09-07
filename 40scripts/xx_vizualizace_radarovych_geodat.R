
# Práce s radarovými (SAR) geodaty a jejich vizualizace ------------------

# zkusme složitější kombinaci filtrů a vybírání pásem
# příkladová data vezmeme záměrně z mise Sentinelu-1, která se zaměřuje na radarová geodata

# načteme balíčky pro další práci
xfun::pkg_attach2(
  "tidyverse",
  "rgee",
  "tidyrgee"
)

# inicializujeme připojení
ee_Initialize(
  "ledvinka@natur.cuni.cz",
  # kdybychom chtěli geodata dostat na lokální disk (nebo do RAM), aktivujeme i Google Drive
  drive = T
)

# odkážeme se na dataset Sentinelu-1
col <- 
  ee$ImageCollection("COPERNICUS/S1_GRD")

# prohlédneme metadata prvního snímku
# vyplatí se to pro základní průzkum dat, kdy např. najdeme základní info o pásmech apod.
col$first() |> 
  ee_print()

# kvůli zaměření na konkrétní místo a jeho okolí konstruujeme bod a buffer okolo něj
pt <- 
  ee$Geometry$Point(15, 50)$
  buffer(30000)

# nakombinujeme filtry pro místo a čas
col2 <- 
  col$filterBounds(pt)$
  filterDate("2026-01-01", "2026-07-01")

# funkce tidyrgee::as_tidyee() také dopomáhá k prozkoumání detilů kolekce
col2_tidy <- 
  as_tidyee(col2)

# prohlédneme zejména tabulku 'vrt'
col2_tidy |> 
  pluck("vrt") |> 
  unnest(band_names)

# nyní třeba víme, že jsme se správně omezili na první půlku roku 2026
# také již víme, která pásma můžeme vybírat funkcí select()

# řekněme, že máme za úkol omezit se na mód přístroje 'IW'
# a také na sestupnou orbitu
# ale nevíme nic o konkrétním názvu vlastností, na jejichž hodnoty se můžeme omezit
col2$first()$
  propertyNames()$
  getInfo() |> 
  str_subset("[I|i]nstrument")

col2$first()$
  propertyNames()$
  getInfo() |> 
  str_subset("[O|o]rbit")

# když se např. omezíme na vlastnost 'orbitProperties_pass', vydáme se správnou cestou?
col2$aggregate_array("orbitProperties_pass")$
  distinct()$
  getInfo()

# nyní aplikujme poslední filtry
col3 <- 
  col2$filter(ee$Filter$eq("orbitProperties_pass", "DESCENDING"))$
  filter(ee$Filter$eq("instrumentMode", "IW"))$
  select("VV", "VH") # úhel nás nezajímá

# ještě jendou zkontrolujeme, zda filtry zabraly
col3_tidy <- 
  as_tidyee(col3)

col3_tidy |> 
  pluck("vrt") |> 
  unnest(band_names)

# vybereme první snímek a vykreslíme dohromady polarizační pásma VV a VH
prvni <- 
  col3$first()

# nejprve definice vizualizačních parametrů
visParamGrey <- list(
  min = -18, 
  max = 0
)

# centrujeme na náš bod a okolí
Map$centerObject(pt, 9)

# a kreslíme
Map$addLayer(
  prvni$select("VV"), 
  visParamGrey, 
  "VV polarised band"
) + 
  Map$addLayer(
    prvni$select("VH"), 
    visParamGrey, 
    "VH polarised band"
  )
