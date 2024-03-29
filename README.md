
![3DForEcoTech-logo-description](https://user-images.githubusercontent.com/5663984/174446150-32e31872-2003-4af9-95d4-a1abfca0b744.png)

# Sensor-agnostic tree species classification using proximal laser scanning (TLS, MLS, ULS) and CNNs 🌳🌲💥🤖
Repository for the work related to the tree species classification using proximally sensed laser scanning data (TLS, MLS, ULS). This work is part of the COST action 3DForEcoTech [3DForEcoTech](https://3dforecotech.eu/) and co-funded by [SmartForest](https://smartforest.no/)

![beech_spruce_pine](https://user-images.githubusercontent.com/5663984/205514849-14d77df2-0441-4caa-b230-6fdbdaad4ddc.png)

# What is the study case about
The overall aim consists of developing a **benchmark dataset** for **developing** new point cloud tree species classification models and **benchmarking** them

# Available data sources (approx. 20K trees 🤯)
## Datasets
Below you can find some metadata regarding the available datasets.

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
| 1 | Julian Frey & Zoe Schindler | University of Freiburg | 0.79 | 0.81 | 0.79 | 0.79 | DetailView [github repo](https://github.com/JulFrey/DetailView) |
| 2 | Adrian Straker | University of Goettingen | 0.78 | 0.81 | 0.78 | 0.78 | YOLOv5 [github repo](https://github.com/AWF-GAUG/Yolov5-for-tree-species-classification-in-point-cloud-derived-images) |
| 3 | Matt Allen | University of Cambridge | 0.76 | 0.77 | 0.76 | 0.76 | SimpleView [github repo](https://github.com/mataln/TLSpecies) |
| 4 | Lukas Winiwarter | UBC/TU Wien | 0.76 | 0.77 | 0.76 | 0.75 | PointNet++ [github repo](https://github.com/lwiniwar/Tr3D_species_lwiniwar) |
| 5 | Nataliia Rehush | WSL | 0.74 | 0.77 | 0.74 | 0.73 | MinkNet [github repo](https://github.com/nrehush/minknet-tree-species) |
| 6 | Hristina Hristova & Nataliia Rehush | WSL | 0.71 | 0.72 | 0.71 | 0.7 | MLP-Mixer [github repo](https://github.com/Hrisi/tree-species-classification) |
| 7 | Brent Murray | UBC | 0.68 | 0.67 | 0.68 | 0.67 | PointAugment + DGCNN  [github repo](https://github.com/Brent-Murray/TR3D_PointAugDGCNN) |


# Confusion matrix of top performing method 📈

![Tr3D_species_submissions_UniFreib_confusion_matrix](https://github.com/stefp/Tr3D_species/assets/5663984/87f73e7e-c049-467d-82d4-eec9869ae47d)




