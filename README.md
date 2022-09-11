
![3DForEcoTech-logo-description](https://user-images.githubusercontent.com/5663984/174446150-32e31872-2003-4af9-95d4-a1abfca0b744.png)

# Tree species classification using proximal laser scanning (TLS, MLS, ULS) and CNNs
Repository for the work related to the tree species classification using proximally sensed laser scanning data (TLS, MLS, ULS). This work is part of the COST action 3DForEcoTech (https://3dforecotech.eu/)

# What is the study case about
In this [google doc](https://docs.google.com/document/d/1ZbccmFbWLmyGxzJlcaE7QMqwauBFxgBb3gTPkEImuwg/edit) you can find the description of the study case.
Overall we should develop:
 - a general model (all species and sensors)
 - a general model but using only a cilinder with buffer (fixed or varying?) around the detected DBH
 - a model specific to ecological-climatocgical conditions (e.g. boreal, temperate)
 - a model specific to the platform (TLS and ULS)

# Available data sources (for now 18K trees)
The following google sheet describes the ava8lable datasets:
https://docs.google.com/spreadsheets/d/1-HPtnaIR7NCAsvfiKfIwKoXwYKKy_oqfgBvkJBkN-HU/edit#gid=0


| Dataset name  | Data URL | Paper URL | Downloaded | Prepared | n trees | n species | Data type | Sensor | Quality annotation |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| NIBIO Geoslam  | [link data](...) | [link paper](...) | ✔️ | ✔️ | 833 | 3 | MLS | Geoslam Horizon | top |
| ForInstance  | [link data](https://nibio-my.sharepoint.com/:f:/g/personal/stefano_puliti_nibio_no/EuBtG3q5teVAnPuaC7bB56YBkV5M5VWK4OhOzuWBd3I2oA?e=4Ebkwx) | [link paper](https://www.mdpi.com/2072-4292/7/8/9632) | ✔️ | ✔️ | 885 | 5 | ULS | VUX/miniVUX series | top |
| Seidl_2021  | [link data](https://data.goettingen-research-online.de/dataset.xhtml?persistentId=doi:10.25625/FOHUJM) |[link paper](https://www.frontiersin.org/articles/10.3389/fpls.2021.635440/full) | ✔️ | ✔️ | 690 | 8 | TLS |  Faro Focus 3D 120 and Zoller and Fröhlich Imager 5006 | top |
| Weiser_2021 | [link data](https://pytreedb.geog.uni-heidelberg.de) | [link paper](https://essd.copernicus.org/preprints/essd-2022-39/) | ✔️ | ✔️ | 1491 | 22 | ALS/ULS(leaf-on and off)/TLS | miniVUX1 ... | medium |
| VanDenBerge_2021 | [link data](https://github.com/ekalinicheva/multi_layer_vegetation)  | [link paper](https://link.springer.com/article/10.1007/s12155-021-10250-y) | ✔️ | ✔️ | 69 | 3 | TLS | RIEGL VZ-1000 | top |
| LAUTx | [link data](https://zenodo.org/record/6560112#.YrNjx3ZBxaQ)  | [link paper](https://zenodo.org/record/6560112/files/APPENDIX_TABLES.pdf?download=1) | ✔️ | ✔️ | 515 | ? | MLS | ZEB Horizon | top |
| Saarinen_2021 | [link stems](https://zenodo.org/record/3701271#.YrQL8mBBxaS) [link crowns](https://zenodo.org/record/5783404#.YrQL_GBBxaS)  | [link paper](https://zenodo.org/record/5783404/files/Saarinen%20et%20al_Data%20descriptor.pdf?download=1) | ✔️ | ✔️ | 1976 | 1 | TLS | Trimble TX5 3D | poor |
| Julian Frey |  [link data](S:\Prosjekter\52106_SFI_SmartForest\annotated_datasets\speciesClassification_proximalLS\Frey_2022) | no paper | ✔️ |  ✔️ | 745 | 6 | TLS | ... | poor |
| Bluecat | [link stems](https://zenodo.org/record/4624277#.YrYt3HZByUk)  | [link paper](https://www.mdpi.com/2072-4292/13/12/2297) | ✔️ | ✔️ | 10000 | ? | TLS | ... | top |
| Brede_2017 | [link data](https://data.4tu.nl/articles/dataset/Speulderbos_Terrestrial_TLS_and_Unmanned_Aerial_Vehicle_Laser_Scanning_UAV-LS_2017/13061306) | [link paper](https://research.wur.nl/en/datasets/speulderbos-terrestrial-tls-and-unmanned-aerial-vehicle-laser-sca) | ❌ | ❌ | ? | need to ask | ULS/TLS | ... |
| Cedric Vega | no data link | no paper | ❌ | ❌ | ? | ? | TLS | ... |
| Martin Mokros | no data link | no paper | ❌ | ❌ | ? | ? | ? | ... |
| Kim Calders | no data link | no paper | ❌ | ❌ | ? | ? | ? | ... |
| Harry Owen | no data link | no paper | ❌ |  ❌ | ? | ? | TLS | ... |

For now this is the number of trees by tree species&genus and data type in the available datasets:

By species
![Rplot02](https://user-images.githubusercontent.com/5663984/189543968-054790df-395d-4f32-97c9-aaf56c6e1edd.png)

By genus
![genus](https://user-images.githubusercontent.com/5663984/189543978-34cf634f-ecc5-4ceb-b4b3-6f1aa4bb2c4b.png)


### Need to balance the dataset:
- The objective is to reduce the representativeness of the classes with most trees while still ensuring a large-enough sample of trees for modelling. To do so we should select a number of trees to sample from each tree species e.g. 100 trees)
- Here we should then apply a stratified random sampling where the strata are the single acquisitions represented by the main folders (i.e. combination of sensor and acquisition platform).
- When sampling within each strata we should account for tree size (i.e. sub-strata) to ensure that we cover as much possible the tree size range.

### Train, validation, test split:
- Based on the previous stratified sample we should select 70% of the data for training, 15% for validation, and 15% for test
- The split should be done by acquisition (is it possible based on the available data? we only have a few projects and it could be detrimental to do this), meaning that we should not have in the training data trees from the same areas as the validation data.


### Models to test
- TensorFlow Hub - resnet50 (https://github.com/stefp/treeSpecies_classify_LS/blob/main/scripts/Tree_SP_transfer_learning_with_hub.ipynb)
- yolov5 v 6.2 classification (https://github.com/ultralytics/yolov5/releases)


### Train separate models for different biogeographical regions
- Boreal: Picea abies, Pinus sylvestris, Betula pendula 
- Boreal+: Picea abies, Pinus sylvestris, Betula pendula, Fagus sylvatica, Quercus sp., Acer sp., Tilia sp., Fraxinus exclesior
- Temperate: Picea abies, Pinus sylvestris, Betula pendula, Fagus sylvatica, Quercus sp., Acer sp., Carpinus betulus, Pseudotsuga mentziesii, Tilia cordata, Ulmus, Prunus, Crategous, Larix)
- Australia: Eucaliptus sp.
 

### Useful litterature
- https://www.frontiersin.org/articles/10.3389/fpls.2021.635440/full
- https://www.mdpi.com/2072-4292/14/15/3809
- https://www.spiedigitallibrary.org/conference-proceedings-of-spie/10332/103320O/Lidar-based-individual-tree-species-classification-using-convolutional-neural-network/10.1117/12.2270123.short?SSO=1
- https://www.mdpi.com/2072-4292/13/23/4750
- 

### Example model for species is boreal
![cm](https://user-images.githubusercontent.com/5663984/176134068-2a72bc88-40b2-46ae-b0e2-ae074840f0a8.png)



