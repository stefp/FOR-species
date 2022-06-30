# for instance to tree species
library(lidR)

root_dir="S:/Prosjekter/Drone data/data/2020/InternationalBenchmark_UAVLS/final_dataset"
out_dir="S:/Prosjekter/52106_SFI_SmartForest/annotated_datasets/speciesClassification_proximalLS/ForInstance"

sub_dirs= list.dirs(root_dir, recursive = F)

treeSP_lookup= data.frame(code=c(1,2,3,4,5),
                          sp=c("picea_abies","pinus_silvestris", "betula_pendula","pinus_radiata", "eucaliptus_sp"))

# iterate through each dataset
i=5

plots= list.files(sub_dirs[i], pattern=c("*.las","*.laz"), full=T)
meta= list.files(sub_dirs[i], pattern=c("*.csv"), full=T)
data_origin=basename(sub_dirs[i])

meta= read.table(meta, sep=",", header=T)
#colnames(meta)[1]="plotID"

## iterate through each plot
for (j in 1:length(plots)){
  one_plot=readLAS(plots[j])
  plotID= as.numeric(unlist(regmatches(basename(plots[j]), gregexpr("[[:digit:]]+", basename(plots[j])))))  
  meta_plot=meta[meta$plotID==plotID,]
  
  print(paste0("exporting plot ID ", plotID))
  # iterate through each tree
  for (k in unique(one_plot@data$treeID)){
    if (k ==0){next}
    
    #select tree point cloud
    tree_pc=(one_plot@data[one_plot@data$treeID==k,])
    # keep only x, y, and z
    tree_pc= tree_pc[,c(1,2,3)]
    
    
    # get tree metadata
    meta_tree= meta_plot[meta_plot$treeID==k,]
    tree_sp=treeSP_lookup[treeSP_lookup$code==meta_tree$treeSP,]$sp
    
    # set writing dir
    dir_write= paste0(out_dir,"/",tree_sp)
    dir.create(dir_write, showWarnings = F)
    
    #write out
    write.table(tree_pc, file = paste0(dir_write,"/",data_origin, "_tree",k, "_plot", plotID,".txt"), row.names = F, quote = F)
    
  
    }
  

}


