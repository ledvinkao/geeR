# Inicializace připojení ke Google Earth Engine (GEE) API ----------------

# v následujících skriptech budeme předpokládat, že již máme založený účet a projekt pro GEE
# stejně tak budeme předpokládat, že máme v pořádku Python prostředí s nutnými knihovnami, přes které si R rozumí s API
# ke komunikaci s GEE API je nezbytný balíček reticulate, který je určiým přemostěním mezi jazyky R a Python

# načteme nejpodstatnější balíček rgee
xfun::pkg_attach2("rgee") # pro tento způsob načítání R balíčků je nutné mít nainstalovaný balíček xfun

# nyní lze zahájit připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz", # každý má svůj uživatelský účet spjatý s profilem na Google
  drive = T # pro práci s malými daty a výstupy není nutné inicializovat připojení ke Google Drive
)

# alternativou k drive = T je gcs = T (aktivuje se tím Google Cloud Storage, pokud jsme si ho zařídili)
# po prvních spuštěních těchto řádků, bude Google požadovat autentikaci (např. vložit do Konzole token a dále něco povolit)
