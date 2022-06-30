# stats

dir_root= "S:/Prosjekter/52106_SFI_SmartForest/annotated_datasets/speciesClassification_proximalLS"

sub_dirs=list.dirs(dir_root, recursive = T)
datasets=list.dirs(dir_root, recursive = F)

all_folders= unique(basename(sub_dirs))

species= all_folders[!all_folders%in% unique(basename(datasets))]

species=species[-1]

all_data= data.frame(sp=species,
                     count=0)

for(i in 1:length(datasets)){
  sp_in_dataset=list.dirs(datasets[i], recursive = F)
  
  for (j in 1:length(sp_in_dataset)){
    sp_to_count=basename(sp_in_dataset[j])
    n_files=length(list.files(sp_in_dataset[j]))
    all_data[all_data$sp%in%sp_to_count,]$count=all_data[all_data$sp%in%sp_to_count,]$count+n_files
  }
}

all_data=all_data[order(all_data$count, decreasing = T),]

mar.default <- c(5,4,4,2) + 0.1
par(mar = mar.default + c(5, 0, 0, 0)) 

barplot(all_data$count, width = 1, space = NULL,
        names.arg = all_data$sp ,las=2)





##################################################################################################################################
