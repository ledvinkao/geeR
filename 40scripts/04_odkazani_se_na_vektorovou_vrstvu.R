# Odkázání se na vektorovou vrstvu (FeatureCollection) -------------------

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# zahájíme připojení
ee_Initialize(user = "ledvinka@natur.cuni.cz")

# na GEE se kromě snímků a jejich kolekcí vyskytují také vektorové vrstvy
# odkažme se např. na celosvětovou vrstvu polygonů povodí řek (např. úroveň 9)
povodi <- ee$FeatureCollection("WWF/HydroSHEDS/v1/Basins/hybas_9")
