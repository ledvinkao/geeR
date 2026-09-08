
# Tvorba vlastní vektorové vrstvy přímo v GEE ----------------------------

# ve skriptu 05 jsme ukázali, jak vytvořit vektorovou vrstvu nejprve v R a pak ji nahrát na GEE
# existují však i možnosti tvorby vektorových vrstev přímo serverovými funkcemi
# k tomuto účelu existují také např. funkce ee$Fetaure() nebo ee$FeatureCollection
# zde si dovolíme práci zjednodušit na pouhý bod

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# vytvoříme bod reprezentující opět astronomický střed Evropy
# defaultne se u souřadnic předpokládá crs s EPSG kódem 4326
pt <- 
  ee$Geometry$Point(15, 50)

# co jsme právě dostali?
class(pt)

pt |> 
  ee_print()

pt$getInfo()

# jedná se o pouhou geometrii
# tu můžeme převést na Feature
# které ještě můžeme dodat vlastnosti (tj. další atributy) prostřednictvím pojmenovaného seznamu
pt2 <- 
  ee$Feature(
    pt,
    list(
      nm = "Kouřim",
      typ = "astronomický střed Evropy"
    )
  )

class(pt2)

pt2 |> 
  ee_print()

pt2$getInfo()

# nyní máme Feature, což lze převést na FeatureCollection
pt3 <- 
  ee$FeatureCollection(pt2)

class(pt3)

pt3 |> 
  ee_print()

pt3$first()$propertyNames()$getInfo()
