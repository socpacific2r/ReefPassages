  ###################################
  # Graph edition for passes transects
  # Author : Nathan Lafont-Kerbrat
  # Creation date : 14.04.25
  # Latest update : 15.05.25
  ####################################
  
  #### Librairies and  WD ####
  
  rm(list = ls())
  
  library(readr)
  library(dplyr)
  library(ggplot2)
  
  
  
  WD <- dirname(rstudioapi::getActiveDocumentContext()$path)
  if (!is.null(WD)){
    setwd(WD)
    getwd()
  }
  
  
  profile_points <- read.csv("../../data/_data_for_transects/moorea_profile_points.csv")
  # -> File name needs to be adapted to the profile point csv to compute.
  
  path_to_transects_repo <- "../../media/webmap/transects/"
  
  unique_lines <- unique(profile_points$LINE_ID)
  
  for (line in unique_lines) {
    # Filter data for current line treatment 
    subset_profile_points <- profile_points %>% filter(LINE_ID == line)
    
    # Create graphics with ggplot for the current section
    p <- ggplot(subset_profile_points, aes(x = DIST, y = Z)) +
      geom_line(color = "blue") +
      ggtitle(paste("Transect for reef passage n°", line)) +
      xlab("Distance from first point of the transect line (m)") +
      ylab("Depth (m)") +
      theme_bw() +
      theme(plot.title = element_text(hjust = 0.5))
    
    # Save current graphic
    ggsave(filename = paste0(path_to_transects_repo, line, "_transect.png"), plot = p, width = 8, height = 4, dpi = 300)
  }
  
  