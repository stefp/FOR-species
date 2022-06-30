# prepare Saarinen2021 dataset
library(lidR)

dir_root="S:/Prosjekter/52106_SFI_SmartForest/annotated_datasets/speciesClassification_proximalLS/Saarinen2021"
dir_field_data= paste0(dir_root,"/Field_reference")
out_dir=paste0(dir_root,"/pinus_sylvestris")
dir.create(out_dir, showWarnings = F)

# list all files
crowns_stems=list.files(dir_root, full=T, recursive = T, pattern="*.txt")
crowns=crowns_stems[substr(basename(dirname(crowns_stems)),nchar(basename(dirname(crowns_stems)))-10,nchar(basename(dirname(crowns_stems))))==
                      "crownpoints"]
crown_df=data.frame(path=crowns,
                    aoiID=NA,
                    plotID=NA,
                    treeID=NA)
for (c in 1:length(crowns)){
  crown_df[c,]$aoiID= as.numeric(gsub("\\D", "", strsplit(basename(crowns[c]),"_")[[1]][1]))
  crown_df[c,]$plotID= as.numeric(gsub("\\D", "", strsplit(basename(crowns[c]),"_")[[1]][2]))
  crown_df[c,]$treeID= as.numeric(gsub("\\D", "", strsplit(basename(crowns[c]),"_")[[1]][3]))
}

stems=crowns_stems[substr(basename(dirname(crowns_stems)),nchar(basename(dirname(crowns_stems)))-10,nchar(basename(dirname(crowns_stems))))==
                      "_stempoints"]
stems_df=data.frame(path=stems,
                    aoiID=NA,
                    plotID=NA,
                    treeID=NA)
for (c in 1:length(crowns)){
  stems_df[c,]$aoiID= as.numeric(gsub("\\D", "", strsplit(basename(stems[c]),"_")[[1]][1]))
  stems_df[c,]$plotID= as.numeric(gsub("\\D", "", strsplit(basename(stems[c]),"_")[[1]][2]))
  stems_df[c,]$treeID= as.numeric(gsub("\\D", "", strsplit(basename(stems[c]),"_")[[1]][3]))
}

# load field data
field_sheets=list.files(dir_field_data, full=T)


# iterate through each field sheet
for (i in 1:length(field_sheets)){
  # aoi and plot IDs
  aoiID_i=  as.numeric(gsub("\\D", "", strsplit(basename(field_sheets[i]),"_")[[1]][1]))
  plotID_i=  as.numeric(gsub("\\D", "", strsplit(basename(field_sheets[i]),"_")[[1]][2]))

  # read in the plot field data
  one_plot=read.table(field_sheets[i], header=T, sep=";", dec=".")
  
  ##################################
  # iterate through each tree and export data
  for (j in 1:nrow(one_plot)){
    one_tree_field=one_plot[j,]
    # export ony scots pines
    if(one_tree_field$sp!=1){next}
    #export only group 1
    if(one_tree_field$treegroup!=1){next}
    
    # treeID
    treeID_j= one_tree_field$treeID
    
    # find corresponding crown and stem
    stem_path=stems_df[stems_df$aoiID==aoiID_i & 
                        stems_df$plotID==plotID_i &
                        stems_df$treeID== treeID_j, ]$path
    crown_path=crown_df[crown_df$aoiID==aoiID_i & 
                          crown_df$plotID==plotID_i &
                          crown_df$treeID== treeID_j, ]$path
    
    # read in the TLS data as tables
    stem= read.table(stem_path, header=T, sep=" ")
    names(stem)= c("X","Y","Z","treeID")
    head(stem)
    
    crown= read.table(crown_path, header=T, sep=" ")
    names(crown)= c("X","Y","Z","treeID")
    head(crown)
    
    # assign label based on krisanski
    # Krisanski classes:
    # 1: Terrain 
    # 2: Vegetation
    # 3: Coarse woody debris
    # 4: Stems/branches
    stem$label=4
    crown$label=2
    
    # merge files
    tree= rbind(stem,crown)
    
    # convert to .las file
    tree=LAS(tree)
    # add extra fields
    tree= add_lasattribute(tree,as.integer(tree$treeID) , name="treeID",desc="tree ID")
    tree= add_lasattribute(tree,as.integer(tree$label) , name="label",desc="tree ID")
    #plot(tree, color="label")
    
    # export .las file in pine folder
    filename=paste0("vh", aoiID_i,"_plot",plotID_i,"_tree",treeID_j,".las")
    writeLAS(tree, paste0(out_dir,"/",filename))

  }
  
}