# Funkce distinct() jako pomocník při průzkumu unikátních hodnot metadat ----

# někdy se může hodit zjistit si, jaké jsou unikátní hodnoty nějaké vlastnosti
# ve skriptu 16 jsme se omezovali na orbitProperties_pass == "DESCENDING"
# ale co když o hodnotách této vlastnosti snímků nevíme nic?

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# napojme se se na stejnou kolekci snímků jako ve skriptu 16
# též filtrujme
col <-
  ee$ImageCollection("COPERNICUS/S1_GRD")$filterDate(
    "2026-01-01",
    "2026-07-01"
  )$filterBounds(ee$Geometry$Point(15, 50))

# nyní aplikujme kombinaci serverových funkcí distinct() a aggregate_array()
col$aggregate_array("orbitProperties_pass")$distinct()$getInfo() # abychom dostali vektor hodnot do R
