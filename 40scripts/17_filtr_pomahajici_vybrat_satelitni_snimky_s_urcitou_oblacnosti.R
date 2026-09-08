# Filtrování kolekce snímků coby pomocník při výběru snímků s určitou oblačností ----

# kvalita optických dat je často závislá na oblačnosti
# u snímků mise Sentinel-2 jsou proto metadata, které s procentem oblačnosti souvisejí
# lze zde tedy s výhodou využít filtrování podle metadat

# načteme balíček rgee
# vezmeme si také na pomoc tidyverse
xfun::pkg_attach2(
  "tidyverse",
  "rgee"
)

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# napojíme se na kolekci snímků mise Sentinel-2
# a rovnou aplikujeme základní filtry podle času a místa
col <-
  ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED")$filterDate(
    "2026-01-01",
    "2026-07-01"
  )$filterBounds(ee$Geometry$Point(15, 50))

# předpokládejme, že název metadat, na základě kterého budeme moci vybírat vhodné snímky (např. s oblačností), neznáme
# tak si ho zkusíme najít podle slovíčka 'cloud' nebo 'CLOUD'
# zapojíme do hry i slovesa tidyverse
col$first()$propertyNames()$getInfo() |>
  str_subset("cloud|CLOUD")

# řekněme, že se jedná o vlastnost 'CLOUDY_PIXEL_PERCENTAGE'
# takže filtrujeme, např. na snímky s podílem pixelů s oblaky menším než je 20 %
col2 <-
  col$filter(ee$Filter$lt("CLOUDY_PIXEL_PERCENTAGE", 20))

# zabralo to?
col$size()$getInfo()

col2$size()$getInfo()

# dodejme, že takto jsme se odkazovali na procento oblačných pixelů v celém snímků (dlaždici)
# tento způsob tedy neřeší problematiku oblačnosti v zájmovém polygonu
