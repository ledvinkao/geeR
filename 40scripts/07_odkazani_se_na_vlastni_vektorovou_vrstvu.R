# Odkázání se na vlastní vektorovou vrstvu -------------------------------

# jakmile máme v jakémkoliv assetu nahranou vlastní vektorovou vrstvu, lze se na ni také odkázat
# to pak umožní pracovat s ni dále i vhledem k dalším datasetům na GEE

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# zahájíme připojení
ee_Initialize(user = "ledvinka@natur.cuni.cz")

# a odkážeme se na vrstvu za znalosti odkazu ze skriptu 06
stred <- ee$FeatureCollection(
  "projects/ee-ledvinka/assets/astronomicky_stred_evropy"
)

# každý samozřejmě bude mít svůj odkaz, a to včetně cesty k adresáři s názvem projektu
