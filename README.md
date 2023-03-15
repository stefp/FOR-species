
![3DForEcoTech-logo-description](https://user-images.githubusercontent.com/5663984/174446150-32e31872-2003-4af9-95d4-a1abfca0b744.png)

# Sensor-agnostic tree species classification using proximal laser scanning (TLS, MLS, ULS) and CNNs 🌳🌲💥🤖
Repository for the work related to the tree species classification using proximally sensed laser scanning data (TLS, MLS, ULS). This work is part of the COST action 3DForEcoTech [3DForEcoTech](https://3dforecotech.eu/) and co-funded by [SmartForest](https://smartforest.no/)

![beech_spruce_pine](https://user-images.githubusercontent.com/5663984/205514849-14d77df2-0441-4caa-b230-6fdbdaad4ddc.png)

# What is the study case about
In this [google doc](https://docs.google.com/document/d/1ZbccmFbWLmyGxzJlcaE7QMqwauBFxgBb3gTPkEImuwg/edit) you can find an initial idea of the study case.

Overall, in this acitivity we should:
 - Provide a **benchmark dataset** for **developing** new point cloud classification models and **evaluating** existing methods.
 - Benchmark several methods (data science competition)
 - Publish the best models, code, the data, and of course a nice paper :)

# Available data sources (approx. 20K trees 🤯)
## Datasets
In this [google sheet](https://docs.google.com/spreadsheets/d/1qxj27Yh8B33I5eS9MAO9V_PJsr9OxU-kN3pY4TSlWHY/edit?usp=sharing)  sheet you can find some metadata regarding the available datasets. 

| dataset_name  | n_trees | n_species | data_type | Sensor | acquisition | annotation_quality | forest_type | x | y |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| wieser_TLS  | 264 | 12 | TLS | RIEGL VZ-400 | 15 scans per ha | manual | temperate | 14.7073 | 48.6638 |
| ...  | ... | ... | ... | ... | ... | ... | ... | ... | ... |

![Capture](https://user-images.githubusercontent.com/5663984/205518571-e7d85b0d-79ae-4dae-98da-99a1c4d7ff79.PNG)


## Trees 
Tree metadata can be found in the tree_metadata_training_publish.csv. Each row represents a single tree with the following fields:

| treeID  | species | genus | dataset | data_type | tree_H | filename |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | 
| 1  | Picea_abies | Picea | wieser_TLS | TLS | 15.5 | /train/00070.las |
| ...  | ... | ... | ... | ... | ... | ... | ... | 

the "tree_H" variable is simply the difference between the top and bottom z value for each tree and should be used only to get a rough understanding of tree size, however keep in mind that this does NOT necessarily correspond to the real tree height.

### Tree distribution by tree species (33 tree species with more than 50 trees)
![species](https://user-images.githubusercontent.com/5663984/205514818-7af03617-e358-44e0-9f40-4c555d6bf3c5.png)

### Tree distribution by genus
![genus](https://user-images.githubusercontent.com/5663984/205514824-9c84acfb-e907-4bc7-8b10-ccff19bad82a.png)

### Tree height (m) distribution by tree species
![species_size](https://user-images.githubusercontent.com/5663984/205514870-8d1ca47f-9fdc-4a70-8a4f-cf197653a58c.png)

# Data science competition (Nov 2022 - May 2023) 🏎️ 
The data science competition will run from Jan 2023 to Apr/May 2023. Each contributor will be able to make a maximum of 3 submissions.

To make a submission should send me (stefano.puliti@nibio.no) a csv file with predictions on the test dataset and with the following two columns:
| treeID  | predicted_species | 
| ------------- | ------------- | 
| 523  | Pinus_sylvestris |  
| ...  | ... |

# Leader board 🏁

| ranking | Author | Institution  | Overall accuracy | Precision | Recall | F1-score | method |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| 1 | Lukas Winiwater | UBC/TU Wien | 0.7 | 0.71 | 0.7 | 0.7 | [github repo](https://github.com/lwiniwar/Tr3D_species_lwiniwar) |
| 2 | Brent Murray | UBC | 0.68 | 0.67 | 0.68 | 0.67 | [github repo](https://github.com/Brent-Murray/TR3D_PointAugDGCNN) |
| 3 | Matt Allen | University of Cambridge | 0.67 | 0.68 | 0.67 | 0.66 | [github repo](https://github.com/mataln/TLSpecies) |

# Confusion matrix of top performing method 📈

![image](https://user-images.githubusercontent.com/5663984/225445681-a809594e-2afe-4a3c-aeb8-8888dc72c0a3.png)





