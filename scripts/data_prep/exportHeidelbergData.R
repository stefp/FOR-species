# export Wieser et al *heidelberg data
library(jsonlite)

dir_jsons= "S:/Prosjekter/52106_SFI_SmartForest/annotated_datasets/speciesClassification_proximalLS/Wieser/geojsons"
out_dir="S:/Prosjekter/52106_SFI_SmartForest/annotated_datasets/speciesClassification_proximalLS/Wieser"
list_jsons= list.files(dir_jsons, pattern="*.json", full=T)


i= 1
for(i in 1:length(list_jsons)){
  one_tree_json= read_json(list_jsons[i], simplifyVector = T)
  tree_sp=one_tree_json$properties$species
  tree_sp=tolower(gsub(" ", "_", tree_sp) ) 

  # set writing dir
  dir_write= paste0(out_dir,"/",tree_sp)
  dir.create(dir_write, showWarnings = F)
  
  # download files
  for (j in 1:length(one_tree_json$properties$data$file)){
    # Specify URL where file is stored
    url=one_tree_json$properties$data$file[j]
    # Specify destination where file should be saved
    destfile= paste0(dir_write,"/", basename(url)) 
    
    # Apply download.file function in R
    #download.file(url, destfile)
      
    # Download using system command
    system(paste0("curl.exe --output ",destfile," --url ", url))
     
  }
  
}



