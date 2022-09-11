# stats

dir_root= "S:/Prosjekter/52106_SFI_SmartForest/annotated_datasets/speciesClassification_proximalLS"

sub_dirs=list.dirs(dir_root, recursive = T)
datasets=list.dirs(dir_root, recursive = F)

# acquisitio-wise metadata
meta_acqu= read.table(paste0(dir_root, "/metadata_treeSPclassification_LS.csv"), sep=",", dec=".", header=T)


# list files
list_trees_txt= list.files(dir_root,pattern = "*.txt",recursive = T, full=T)
list_trees_xyz= list.files(dir_root,pattern = "*.xyz",recursive = T, full=T)
list_trees_las= list.files(dir_root,pattern = "*.las",recursive = T, full=T)
list_trees_laz= list.files(dir_root,pattern = "*.laz",recursive = T, full=T)

paths_all_trees= c(list_trees_txt,list_trees_xyz,list_trees_las,list_trees_laz)


meta_tree= data.frame(path=paths_all_trees
                      , filename=basename(paths_all_trees)
                      , species=basename(dirname(paths_all_trees))
                      , genus=NA
                      , dataset=basename(dirname(dirname(paths_all_trees)))
                      , data_type=NA)

# remove files that are not pointclouds
meta_tree=meta_tree[meta_tree$dataset!="annotated_datasets",]

# add additional fields

for(i in 1:nrow(meta_tree)){
  
  meta_tree[i,]$genus=strsplit( meta_tree[i,]$species,"_")[[1]][1]
  meta_tree[i,]$data_type= meta_acqu[meta_acqu$Dataset.name==meta_tree[i,]$dataset,]$Data.type
  
}


# remove ALS trees
meta_tree=meta_tree[meta_tree$data_type!="ALS",]

###################################################################################################
# plot frequencies by tree species and sensor data
library(ggplot2)


meta_tree$species <- factor(meta_tree$species,
                       levels = names(table(meta_tree$species)[order(table(meta_tree$species), decreasing = T)]))

# plot frequencies by tree species and data type
ggplot(meta_tree, aes(species, fill=data_type), decreasing =T)+ geom_bar()+  theme(axis.text.x=element_text(angle = 90, hjust = 0))

# plot frequencies by tree genus and data type
meta_tree$genus <- factor(meta_tree$genus,
                            levels = names(table(meta_tree$genus)[order(table(meta_tree$genus), decreasing = T)]))

ggplot(meta_tree, aes(genus, fill=data_type), decreasing =T)+ geom_bar()+
  theme(axis.text.x=element_text(angle = 90, hjust = 0))

# write tree metadata

write.table(meta_tree, paste0(dir_root,"/metadata_trees.csv"), sep=",", dec=".",row.names = F, quote = F)

