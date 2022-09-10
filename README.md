
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

For now this is the frequency of the species in the available datasets:
![Rplot](https://user-images.githubusercontent.com/5663984/189360819-06decd01-d663-42c8-86b5-40e5e5f0795e.png)

### Need to balance the dataset:
- The objective is to reduce the representativeness of the classes with most trees while still ensuring a large-enough sample of trees for modelling. To do so we should select a number of trees to sample from each tree species e.g. 100 trees)
- Here we should then apply a stratified random sampling where the strata are the single acquisitions represented by the main folders (i.e. combination of sensor and acquisition platform).
- When sampling within each strata we should account for tree size (i.e. sub-strata) to ensure that we cover as much possible the tree size range.

### OPther links to check for data availability:
- this may be a resource but it is only for Australia: https://portal.tern.org.au/nsw-forest-monitoring-lidar-pilot/23739 and  https://data.tern.org.au/nsw/gblidar/NSW_Natural_Resources_Commission/NSW_Natural_Resources_Commission/
- https://datadryad.org/stash/dataset/doi:10.5061/dryad.02dq2
- https://bitbucket.org/tree_research/wytham_woods_3d_model/src/master/

### Useful litterature
- https://www.frontiersin.org/articles/10.3389/fpls.2021.635440/full
- 

### Example model for species is boreal
![cm](https://user-images.githubusercontent.com/5663984/176134068-2a72bc88-40b2-46ae-b0e2-ae074840f0a8.png)



