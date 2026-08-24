# Nahrání vlastní vektorové vrstvy ---------------------------------------

# existuje možnost nahrát na GEE vlastní vektorovou vrstvu
# lze to provést ve webovém kódovacím prostředí, ale i programaticky
# k programatickému nahrání vlastní vrstvy potřebujeme hlavně znát cestu projektovým assetům
# existují cloudové assety a tzv. legacy assety
# zvolme např. cloudový asset (každý bude mít cestu podle vlastního názvu projektu)

# načteme potřebné balíčky
xfun::pkg_attach2(
  "tidyverse", # umoňuje zacházet s daty v tidyverse pojetí
  "sf", # pro lokální práci s vektorovými vrstvami
  "rgee"
)

# inicializujeme připojení
ee_Initialize(user = "ledvinka@natur.cuni.cz")

# vytvořme nejprve lokálně bod reprezentující např. astronomický střed Evropy
stred <- st_point(c(15, 50)) |>
  st_sfc(crs = 4326) |>
  st_sf() |>
  st_set_geometry("geometry") |>
  mutate(
    name = "Kouřim",
    typ = "astronomický střed Evropy"
  )

# funkce rgee::st_as_ee() je určena ke konverzi lokální geometrie, geometrického sloupce nebo vektorové vrstvy na GEE protějšky
sf_as_ee(
  stred,
  via = "getInfo_to_asset", # vrstva se nenahraje, pokud necháme možnost "getInfo" (ta jen konvertuje do dočasného objektu)
  assetId = "projects/ee-ledvinka/assets/astronomicky_stred_evropy" # je nutné znát cestu ke složce s assety a na konec dodat název naší nové vrstvy
)
