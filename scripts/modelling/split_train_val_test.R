# split into training, validation and test

dir_root= "S:/Prosjekter/52106_SFI_SmartForest/annotated_datasets/speciesClassification_proximalLS/images"


split=0.3


images=list.files(dir_root, pattern="*.jpg", full=T, recursive=T)

images_df=data.frame(path=NA,
                     filename=NA,
                     species=NA)

for(i in 1:length(images)){
  proj=substr(tools::file_path_sans_ext(basename(images[i])), 1,nchar(tools::file_path_sans_ext(basename(images[i])))-4)
  images_df[i,]$path=images[i]
  images_df[i,]$filename=proj
  images_df[i,]$species=basename(dirname(images[i]))
}


# split into train, val and test 
set.seed(123)
train_names=unique(images_df$filename)[sample(1:length(unique(images_df$filename)),length(unique(images_df$filename))*(1-split))]
val_names=unique(images_df$filename)[!unique(images_df$filename)%in%train_names]
#test_names=val_names[sample(1:length(val_names),length(val_names)*0.5)]
#val_names=val_names[!val_names%in%test_names]

images_df$train=0
images_df[images_df$filename%in%train_names,]$train=1

train_path=paste0(dir_root, "/train")
val_path=paste0(dir_root, "/val")
#test_path=paste0(dir_root, "/test")

dir.create(train_path, showWarnings = F)
dir.create(val_path, showWarnings = F)



for(i in 1:nrow(images_df)){
  if(images_df[i,]$train==1){
    dir.create(paste0(train_path, "/",images_df[i,]$species), showWarnings = F)
    file.copy(images_df[i,]$path, paste0(train_path, "/",images_df[i,]$species))
  } else {
    dir.create(paste0(val_path, "/",images_df[i,]$species), showWarnings = F)
    file.copy(images_df[i,]$path, paste0(val_path, "/",images_df[i,]$species))
  }
  
}







