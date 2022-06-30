# parse LAUTx dataset
library(lidR)

dir_root= "S:/Prosjekter/52106_SFI_SmartForest/annotated_datasets/speciesClassification_proximalLS/LAUTx/PLS_manual_segmentation"
out_dir="S:/Prosjekter/52106_SFI_SmartForest/annotated_datasets/speciesClassification_proximalLS/LAUTx"

reference_data=read.table(paste0(out_dir,"/reference_data.csv"), header=T, sep=",")
head(reference_data)


treeSP_lookup= data.frame(abb=c("be","oak","sp","pin","la","fir",NA,"hb","cher","pop","sall","bir","map","ash","elm"),
                          sp=c("fagus_silvatica",
                               "quercus",
                               "picea_abies",
                               "pinus_silvestris","larix_decidua","abies_alba",NA,
                               "hb","cherry","poplar","sall","birch","maple","fraxinus_excelsior","ulmus_glabra"))


list_trees_pc=list.files(dir_root, full=T)

for (i in 1:length(list_trees_pc)){
  one_tree=readLAS(list_trees_pc[i])
  plotID=as.numeric(unlist(regmatches(substr(basename(list_trees_pc[i]),1,3), gregexpr("[[:digit:]]+", substr(basename(list_trees_pc[i]),1,3)))))
  treeID= as.numeric(unlist(regmatches(substr(basename(list_trees_pc[i]),4,9), gregexpr("[[:digit:]]+", substr(basename(list_trees_pc[i]),4,9)))))
  
  species=reference_data[reference_data$plot_id%in%(plotID) & reference_data$tree_id%in%(treeID) ,]$tree_spec
  species=treeSP_lookup[treeSP_lookup$abb%in%species,]$sp
  
  # set writing dir
  dir_write= paste0(out_dir,"/",species)
  dir.create(dir_write, showWarnings = F)
  
  #write out
  writeLAS(one_tree, paste0(dir_write,"/", basename(list_trees_pc[i])))
  
}