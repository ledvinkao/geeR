# Serverová funkce buffer() ----------------------------------------------

# existují samozřejmě mnohé aplikace, kde se využívá tzv. buffer okolo nějakého vektorového prvku
# za tímto účelem využíváme serverovou funkci buffer()

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# vytvořme nejprve bod
pt <-
  ee$Geometry$Point(15, 50)

# funkce buffer() defaultně akceptuje vzdálenost od prvku v metrech
# řekněme, že budeme chtít dostat 30km buffer kolem našeho bodu
pt_buf <-
  pt$buffer(30000)

# jinak číslo v závorkách může být i záporné, což má význam u polygonů

# je nový objekt polygon?
pt_buf |>
  ee_print()
