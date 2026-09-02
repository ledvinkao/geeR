# Zjištění počtu snímků v kolekci - klasickým způsobem -------------------

# funkčnost časových filtrů se vyplatí kontrolovat
# počet snímků před a po filtrování lze ověřit serverovou funkcí size()

# načteme balíček rgee
xfun::pkg_attach("rgee")

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# načteme nějakou kolekci snímků, např. z družicové mise Sentinel-2
col <-
  ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED")

# zkusme navíc aplikovat časový filtr
col_zari <-
  col$filterDate("2024-09-01", "2024-10-01")

# porovnejme počty snímků v obou kolekcích

# tohle může trvat trochu déle
col$size()$getInfo()

# tohle už je mnohem rychlejší
col_zari$size()$getInfo()

# počet snímků opravdu klesl, ale neodpovídá počtu dnů v měsíci
# důvodem je fakt, že funkce size() vrací počet dlaždic, a to navíc pro celý svět
