# Odkázání se na snímek (Image) ------------------------------------------

# načteme balíček rgee
xfun::pkg_attach2("rgee")

# inicializujeme připojení
ee_Initialize(user = "ledvinka@natur.cuni.cz")

# můžeme se inspirovat javascriptovými příklady
# tyto příkaldy používají tečky tam, kde R vkládá znak pro dolar
# pro další práci si můžeme založit i nový (námi pojmenovaný) objekt
img <- ee$Image("ESA/WorldCover/v100")
