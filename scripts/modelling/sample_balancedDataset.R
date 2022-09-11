# select a stratified random sample from full dataset to create a more balanced dataset
library(dplyr)

# parameters
n=500 # max number of trees to sample from each species
seed=123 # set random seed

train=0.7
val=0.15
test=0.15

#
dir_root= "S:/Prosjekter/52106_SFI_SmartForest/annotated_datasets/speciesClassification_proximalLS"

# read in the tree metadata
all_trees= read.table( paste0(dir_root,"/metadata_trees.csv"), sep=",", dec=".",header=T)

# iterate through each species and 
balanced_data=list()

count=1
for(treeSP in unique(all_trees$species)){
  # select trees from each tree species
  all_trees_SP= all_trees[all_trees$species==treeSP,]
  
  # sample from the population of trees
  if(nrow(all_trees_SP)>n){
    set.seed(seed)
    sample_trees_SP= all_trees_SP[sample(1:nrow(all_trees_SP), n),]
    balanced_data[[count]]=sample_trees_SP
    count=count+1
  } else {
    balanced_data[[count]]=all_trees_SP
    count=count+1
  }
  
  }

# merge all sampled trees
balanced_data_df= do.call(rbind,balanced_data)


###################################################################################
# split into train, validation and test
balanced_data_df$split=NA
set.seed(seed)
train_data= balanced_data_df[sample(1:nrow(balanced_data_df),nrow(balanced_data_df)*train),]
train_data$split="train"

val_data=balanced_data_df[!balanced_data_df$filename%in%train_data$filename,]
test_data=val_data[sample(1:nrow(val_data),nrow(val_data)*0.5),]
val_data= val_data[!val_data$filename%in%test_data$filename,]

test_data$split="test"
val_data$split="val"

balanced_data_df_split=rbind(train_data,val_data,test_data)


write.table(balanced_data_df_split, paste0(dir_root,"/metadata_trees_balanced_SP_n",n,"_seed",seed,"_split071515",".csv")
            , sep=",", dec=".",row.names = F, quote = F)
##################################################################################
# plot
# plot frequencies by tree species and sensor data
library(ggplot2)
library(ggpubr)

all_trees$species <- factor(all_trees$species,
                            levels = names(table(all_trees$species)[order(table(all_trees$species), decreasing = T)]))
balanced_data_df$species <- factor(balanced_data_df$species,
                                   levels = names(table(all_trees$species)[order(table(all_trees$species), decreasing = T)]))

train_data$species <- factor(train_data$species,
                                   levels = names(table(all_trees$species)[order(table(all_trees$species), decreasing = T)]))
val_data$species <- factor(val_data$species,
                                   levels = names(table(all_trees$species)[order(table(all_trees$species), decreasing = T)]))
test_data$species <- factor(test_data$species,
                                   levels = names(table(all_trees$species)[order(table(all_trees$species), decreasing = T)]))


balanced_data_df$genus <- factor(balanced_data_df$genus,
                                 levels = names(table(all_trees$genus)[order(table(all_trees$genus), decreasing = T)]))

# plot frequencies by tree species and data type

full_data= ggplot(all_trees, aes(species, fill=data_type), decreasing =T)+ 
  geom_bar()+  theme(axis.text.x=element_blank())+ ggtitle("Full data")+ geom_hline(yintercept=n, linetype="dashed")

balanced_data= ggplot(balanced_data_df, aes(species, fill=data_type), decreasing =T)+ 
  geom_bar()+  theme(axis.text.x=element_blank())+ ggtitle("Balanced data")

train_plot=ggplot(train_data, aes(species, fill=data_type), decreasing =T)+ 
  geom_bar()+  theme(axis.text.x=element_blank())+ ggtitle("Train data")
val_plot=ggplot(val_data, aes(species, fill=data_type), decreasing =T)+ 
  geom_bar()+  theme(axis.text.x=element_blank())+ ggtitle("Validation data")
test_plot=ggplot(test_data, aes(species, fill=data_type), decreasing =T)+ 
  geom_bar() + ggtitle("Test data")

ggarrange(full_data, balanced_data, train_plot, val_plot,test_plot,
          nrow = 5, ncol = 1)

