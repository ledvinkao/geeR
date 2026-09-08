
# Tvorba vektorové vrstvy v GEE s více řádky -----------------------------

# ve skriptu 12 jsme ukázali, jak tvořit jednoduchou vektorovou vsrtvu pouze s jednou řádkou
# třída FeatureCollection ale existuje proto, že potřebujeme, aby vektorová vrstva obsahovala více řádků
# v řeči jazyka R se má jednat o ekvivalent třídy sf (simple feature collection)
# ukažme tedy, jak tvořit tyto vsrtvy s více řádky přímo se serverovými funkcemi

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# vytvořme dva body, které sloučíme do třídy FeatureCollection
pt1 <- 
  ee$Feature(ee$Geometry$Point(15, 50),
    list(
      nm = "Kouřim",
      typ = "astronomický střed Evropy"
    )
  )

# bod 2 bude reprezentovat např. suchý poldr Wlodzienin v Polsku
pt2 <- 
    ee$Feature(ee$Geometry$Point(17.827697, 50.116870),
    list(
      nm = "Wlodzienin",
      typ = "suchý poldr"
    )
  )

# nyní oba body sloučíme funkcí ee$FeatureCollection()
col <- 
  ee$FeatureCollection(
    list(pt1, pt2)
  )

# nyní se již ukáží dva prvky kolekce
# a rovněž tak dvě vlastnosti (de facto sloupce v řeči R)
col |> 
  ee_print()
