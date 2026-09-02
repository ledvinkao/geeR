# Limitování kolekce snímků podle datumu ---------------------------------

# v naprosté většině případů nebudeme pracovat s celou kolekcí snímků
# proto je žádoucí se naučit filtrovat kolekci podle datumu, který je každému snímku většinou přiřazen
# tím spíše, pokud jde o časovou řadu snímků

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# zkusme demonstrovat na snímcích družicové mise Sentinel-2
col <-
  ee$ImageCollection("COPERNICUS/S2_SR_HARMONIZED")

# řekněme, že nás zajímá měsíc září 2024, kdy v Česku probíhaly velké povodně
# při filtrování musíme pamatovat nato, že konečné datum musí být o jednotku větší
# protože Python nebere rozmezí inkluzivně
col_zari <-
  col$filterDate("2024-09-01", "2024-10-01")
