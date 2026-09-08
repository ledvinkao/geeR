xfun::pkg_attach2("rgee")

ee_Initialize(
  user = "ledvinka@natur.cuni.cz"
)

# Import image
image <- ee$Image("users/franceschini/S1S2Topo")

# Define the bands to be used for classification
predictionBands <- image$bandNames()

predictionBands$getInfo()

# Import samples
samples <- ee$FeatureCollection("users/franceschini/SamplePoints")

samples$getInfo()

# Sample the region
samplesStats <- image$select(predictionBands)$sampleRegions(
  collection = samples,
  scale = 10
)

samplesStats$getInfo()

# Train the classifier
RFclassifier <- ee$Classifier$smileRandomForest(300)$train(
  features = samplesStats,
  classProperty = 'LCCODE',
  inputProperties = predictionBands
)

# Apply the classifier
classified <- image$select(predictionBands)$
  classify(RFclassifier)

# Display the map
palette <- list(
  'cc0013', # 1-urban
  'cdb33b', # 2-agriculture
  'aec3d4', # 3-water
  'f7e084', # 4-sand
  '6f6f6f' # 5-wetland
)
  
  Map$addLayer(
    classified,
    list(
      min = 1,
      max = 5,
      palette = palette
    ),
    'RF classified'
  )

# Remove small pixels
classifiedPP <- classified$focal_median(
  2, 
  'Circle'
)

Map$addLayer(
  classifiedPP,
  list(
    min = 1,
    max =5,
    palette = palette
  ),
'RF PP classified'
)
