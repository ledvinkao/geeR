# Filtrování vektorové vrstvy pomocí regulárních výrazů ------------------

# již víme, jak si zjistit názvy vlastností (metadat) u objektů třídy Image nebo Feature
# podívejme se nyní na případ, kdy si u vektorové vrstvy nejsme jisti přesným zněním
# taková situace může nastat např. u vrstev reprezentujících hranice zemí (nebo administrativní členění těchto zemí)
# Česko v takových vrstvách může vystupovat jako 'Czechia' nebo jako 'Czech Republic'
# v takovém případě mohou pomoci filtry využívající regulární výrazy

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# zahájíme připojení
ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# demonstrujme postup na jedné z administrativních vrstev FAO
adm <- ee$FeatureCollection("FAO/GAUL/2015/level1")

# jaká vlastnost této vrstvy představuje názvy zemí
adm$first()$propertyNames()$getInfo()

# řekněme, že se jedná o 'ADM0_NAME'
# nyní si musíme filtr sestavit za využití jiné funkce, než které nám odpovídají na dotaz na (ne)rovnost
cesko <-
  adm$filter(ee$Filter$stringStartsWith("ADM0_NAME", "Czech"))

# zafungoval filtr?
cesko$size()$getInfo()

ee_print(cesko)
