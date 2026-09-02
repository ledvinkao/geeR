# Zjištění počtu snímků v kolekci - tidyverse přístup --------------------

# těm, kteří jsou zvyklí na práci s daty ve smyslu tidyverse, může zpočátku práce s objekty GEE připadate dosti nepřirozená
# abychom se přiblížili navyklým postupům, můžeme aplikovat funkce balíčku tidyrgee
# tento balíček se určitě hodí ke zkoumání metadat, každopádně pro solidní analýzu GEE opjektů je stále doporučováno osvojit si nativní postupy

# načteme balíček rgee a další balíčky, jejichž funkce se mohou hodit
xfun::pkg_attach(
  "tidyverse", # pro apliklaci funkcí pracujících s tabulkami
  "rgee",
  "tidyrgee" # pro konverzi GEE objektů na uklizené (tabulkové) objekty
)

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# odkažme se na vybranou kolekci a rovnou filtrujme
col <-
  ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED")$filterDate(
    "2024-09-01",
    "2024-10-01"
  )

# převeďme tento GEE objekt na uklizený objekt
col_tidy <-
  col |>
  as_tidyee()

# tento objekt obsahuje tabulku "vrt"
# dotazem na počet řádků této tabulky bychom měli dostat stejný výsledek jako při aplikaci nativních funkcí
nrow(col_tidy$vrt) == col$size()$getInfo()
