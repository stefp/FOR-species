# generate 2D images from single trees
#library(rgdal)
library(lidR)
library("here")
library("tools")
library(rgl)

setwd("S:/Prosjekter/52106_SFI_SmartForest/annotated_datasets/speciesClassification_proximalLS")
load(here("S:/Prosjekter/52106_SFI_SmartForest/annotated_datasets/speciesClassification_proximalLS", "create.a.gif.RData"))

# image rotator and exported
pc2img= function(Angle = 5, dir.folder, Name, zoom=0.5) {
  ## Angle = Angle of rotation and time between frames in the final gif.
  ## dir.folder = New directory for final images and temporal objects.
  ## Name = of each image
  
  library("here")
  library("stringr")
  

  dir.create(dir.folder, showWarnings = F)

  
  angles <- rep(Angle * pi / 180, 360/Angle)
  
  for (j in 1:length(angles)) {
    #rotate
    view3d(userMatrix = rotate3d(par3d("userMatrix"),
                                 angles[j], 0, 0, 1),zoom=zoom)
    aspect3d("iso")
    
    #export image
    rgl.snapshot(filename =
                 str_c(dir.folder, "/",Name,"_", sprintf("%03d", j),
                       ".jpg"))
    
  }
}

####################################################################
# ground threshold (to remove ground or low veg points)
ground_thres_m= 0.5 # m above ground
maxH_m= 40
n_sample=6000 # points to sample within each tree
image_size=c(300,350)
zoom=0.8
angle_rotate=83
# selects only boreal species
boreal=F

# automatically create balanced dataset
balanced=F






# 
dir_root= "S:/Prosjekter/52106_SFI_SmartForest/annotated_datasets/speciesClassification_proximalLS"
out_dir=paste0(dir_root,"/images")
dir.create(out_dir, showWarnings = F)

# list all available trees
all_images_txt=list.files(dir_root, pattern="*.txt", recursive = T)
all_images_xyz=list.files(dir_root, pattern="*xyz", recursive = T)
all_images_laz=list.files(dir_root, pattern="*.laz", recursive = T)
all_images_las=list.files(dir_root, pattern="*.las", recursive = T)
all_files= c(all_images_txt,all_images_xyz,all_images_laz,all_images_las)

boreal_sp=c("picea_abies","pinus_sylvestris","betula_pendula","fraxinus_excelsior")

plot(table(basename(dirname(all_files))))

table(basename(dirname(all_files))[basename(dirname(all_files))%in%boreal_sp])


# remove spruces
spruces=all_files[basename(dirname(all_files))=="picea_abies"]
rest=all_files[basename(dirname(all_files))!="picea_abies"]
if (balanced){
  set.seed(123)
  spruces=spruces[sample(1:length(spruces), 220)]
  all_files=c(spruces, rest)
}


for (i in 1:length(all_files)){# :length(all_files)
  # METADATA 
  dataset_name=basename(dirname(dirname(all_files[i]))) 
  treeSP=basename(dirname(all_files[i])) 
  
  # SELECT ONLY BOREAL SPECIES
  if(boreal){
    
    if (!treeSP%in%boreal_sp){next}
    min_observations= min(table(basename(dirname(all_files))[basename(dirname(all_files))%in%boreal_sp]))
    max_observations= max(table(basename(dirname(all_files))[basename(dirname(all_files))%in%boreal_sp]))
    
    if(balanced){
      angle_df=data.frame(sp_names=names(table(basename(dirname(all_files))[basename(dirname(all_files))%in%boreal_sp])),
                          count=as.numeric(table(basename(dirname(all_files))[basename(dirname(all_files))%in%boreal_sp])))
      angle_df$augment_n= max(angle_df$count)-angle_df$count
      
      angle_df$angle=360/ angle_df$augment_n
      
    }

      
  }
  
  # read tree point cloud
  if(file_ext(all_files[i])=="txt"|file_ext(all_files[i])=="xyz"){
    one_tree_pc=read.table(paste0(dir_root,"/",all_files[i]),header = T )
    names(one_tree_pc)=c("X","Y","Z")
  }
  if(file_ext(all_files[i])=="laz"|file_ext(all_files[i])=="las"){
    one_tree_pc=readLAS(paste0(dir_root,"/",all_files[i]))
    one_tree_pc=one_tree_pc@data
  }
  
  # GEOMETRICAL OPERATIONS
  ## move to local coordinates
  one_tree_pc$X=one_tree_pc$X-min(one_tree_pc$X, na.rm=T)
  one_tree_pc$Y=one_tree_pc$Y-min(one_tree_pc$Y, na.rm=T)
  one_tree_pc$Z=one_tree_pc$Z-min(one_tree_pc$Z, na.rm=T)
  ## remove ground (for some datasets it's quite wrong and it include quite a bit of ground points)
  one_tree_pc=one_tree_pc[one_tree_pc$Z>=ground_thres_m,]
  ## downsample the pointcloud
  if(nrow(one_tree_pc)>6000){
    one_tree_pc=one_tree_pc[sample(1:nrow(one_tree_pc),n_sample),]
  }
  ## convert to LAS object
  one_tree_pc=LAS(one_tree_pc)
  
  
  # create dir where to write species
  write_dir=paste0(out_dir,"/",treeSP)
  dir.create(write_dir, showWarnings = F)
  
  # IMAGE GENERATION
  ## define image size
  par3d(windowRect = c(0, 0, image_size[1], image_size[2])) 
  ## define viewpoint
  view3d( theta = 180, phi = 90, zoom=0.5)
  aspect3d("iso")
  
  ## plot
  plot3d(one_tree_pc@data, type="p", col="black"
         , alpha=0.5
         , pch=".", size=0.001,xlab="", ylab="", zlab="", axes = F, site=5, lwd=15
         #,zlim=c(0.5,)
         )
  aspect3d("iso")
  
  ## apply rotations
  pc2img(Angle = angle_rotate,
         dir.folder = write_dir,
         Name = paste0(dataset_name,"_",treeSP,"_",tools::file_path_sans_ext(basename(all_files[i]))),
         zoom=zoom
         )
  ## export
  while (rgl.cur() > 0) { rgl.close() }

}
