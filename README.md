
![3DForEcoTech-logo-description](https://user-images.githubusercontent.com/5663984/174446150-32e31872-2003-4af9-95d4-a1abfca0b744.png)

# Sensor-agnostic tree species classification using proximal laser scanning (TLS, MLS, ULS) and CNNs
Repository for the work related to the tree species classification using proximally sensed laser scanning data (TLS, MLS, ULS). This work is part of the COST action 3DForEcoTech [3DForEcoTech](https://3dforecotech.eu/) and co-funded by SmartForest [SmartForest](https://smartforest.no/)

![spruce_pine_birch](https://user-images.githubusercontent.com/5663984/192355795-8495b87c-a31f-46b1-99fb-58e790845f70.png)


# What is the study case about
In this [google doc](https://docs.google.com/document/d/1ZbccmFbWLmyGxzJlcaE7QMqwauBFxgBb3gTPkEImuwg/edit) you can find an initial idea of the study case.

Overall, in this acitivity we should:
 - Provide a **benchmark dataset** for **developing** new point cloud classification models and **evaluating** existing methods.
 - Benchmark several methods (data science competition)
 - Publish the best models, code, the data, and of course a nice paper :)

[image](https://user-images.githubusercontent.com/5663984/201873118-474a0798-a1f2-4de1-bc82-9063d6dcd592.png)

# Available data sources (for now 24K trees)
## Datasets
In this [google doc](https://docs.google.com/spreadsheets/d/1qxj27Yh8B33I5eS9MAO9V_PJsr9OxU-kN3pY4TSlWHY/edit?usp=sharing)  sheet you can find some metadata regarding the available datasets. 

| dataset_name  | n_trees | n_species | data_type | Sensor | acquisition | annotation_quality | forest_type | x | y |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| wieser_TLS  | 264 | 12 | TLS | RIEGL VZ-400 | 15 scans per ha | manual | temperate | 14.7073 | 48.6638 |
| ...  | ... | ... | ... | ... | ... | ... | ... | ... | ... |

## Trees 
filename	species	genus	dataset	data_type	tree_H

| filename  | species | genus | dataset_name | data_type | tree_H |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | 
| SOR_366.txt  | Picea_abies | Picea | TLS | wieser_TLS | TLS | 15.5 | 
| ...  | ... | ... | ... | ... | ... | ... | 


![image](https://user-images.githubusercontent.com/5663984/201881552-a2a72c3f-a073-4d53-9c2f-ad994c7bae19.png)



For now this is the number of trees by tree species&genus and data type in the available datasets:

By species
![Rplot08](https://user-images.githubusercontent.com/5663984/190494381-5cad989c-fa4b-4cb5-9d7b-b4e95f201b1c.png)

By genus
![Rplot09](https://user-images.githubusercontent.com/5663984/190494397-8315fee8-7a51-498e-a764-5aed9dc91d2b.png)

Tree height (m) distribution by tree species
![Rplot10](https://user-images.githubusercontent.com/5663984/190494422-ee28187a-1955-4c94-91e3-6f4f26375aa2.png)

Geographical overview:
![map_temp](https://user-images.githubusercontent.com/5663984/192165940-31600278-932c-4580-84aa-78ebe12ec16f.PNG)


### Prepare data
#### Need to balance the dataset (undersampling):
- The objective is to reduce the representativeness of the classes with most trees while still ensuring a large-enough sample of trees for modelling. To do so we should select a number of trees to sample from each tree species e.g. 100 trees)
- Here we should then apply a stratified random sampling where the strata are the single acquisitions represented by the main folders (i.e. combination of sensor and acquisition platform).
- When sampling within each strata we should account for tree size (i.e. sub-strata) to ensure that we cover as much possible the tree size range.

#### Train, validation, test split:
- Based on the previous stratified sample we should select 70% of the data for training, 15% for validation, and 15% for test
- The split should be done by acquisition (is it possible based on the available data? we only have a few projects and it could be detrimental to do this), meaning that we should not have in the training data trees from the same areas as the validation data.

#### Example of balanced sample (max 500 trees per species) split into train (70%), validation (15%) and test (15%)
![Rplot04](https://user-images.githubusercontent.com/5663984/189549827-a209d21b-bdbe-40cb-a3c9-0495fae7c8d8.png)


### Models to test
- Matt Allen: https://github.com/mataln/TLSpecies
- TensorFlow Hub - resnet50 (https://github.com/stefp/treeSpecies_classify_LS/blob/main/scripts/Tree_SP_transfer_learning_with_hub.ipynb)
- yolov5 v 6.2 classification (https://github.com/ultralytics/yolov5/releases)
- 

### Train separate models for different biogeographical regions
- Boreal: Picea abies, Pinus sylvestris, Betula pendula 
- Boreal+: Picea abies, Pinus sylvestris, Betula pendula, Fagus sylvatica, Quercus sp., Acer sp., Tilia sp., Fraxinus exclesior
- Temperate: Picea abies, Pinus sylvestris, Betula pendula, Fagus sylvatica, Quercus sp., Acer sp., Carpinus betulus, Pseudotsuga mentziesii, Tilia cordata, Ulmus, Prunus, Crategous, Larix)
- Australia: Eucaliptus sp.
 

### Useful litterature
- Allen github repo: https://github.com/mataln/TLSpecies
- https://www.frontiersin.org/articles/10.3389/fpls.2021.635440/full
- https://www.mdpi.com/2072-4292/14/15/3809
- https://www.spiedigitallibrary.org/conference-proceedings-of-spie/10332/103320O/Lidar-based-individual-tree-species-classification-using-convolutional-neural-network/10.1117/12.2270123.short?SSO=1
- https://www.mdpi.com/2072-4292/13/23/4750
- https://www.sciencedirect.com/science/article/pii/S0924271620302094?via%3Dihub

### Example model for species is boreal
![cm](https://user-images.githubusercontent.com/5663984/176134068-2a72bc88-40b2-46ae-b0e2-ae074840f0a8.png)



