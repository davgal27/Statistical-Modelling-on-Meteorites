############## MAP DISTRIBUTION PLOT 
library(ggplot2)
library(maps)
library(dplyr)
world_map <- map_data("world")

meteorite_map <- ggplot() +
  geom_map(data = world_map, map = world_map, aes(map_id = region),
           color = "black", fill = "lightgray", size = 0.2) +
  
  geom_point(data = meteorite_dataset, aes(x = reclong, y = reclat),
             color = "red", alpha = 0.5, size = 1) +  
  labs(title = "Global Distribution of Meteorite Landings",
       x = "Longitude",
       y = "Latitude") +
  theme_minimal() +
  coord_fixed(ratio = 1.1)  
print(meteorite_map)

############### HEAT MAP PLOT 
world_map <- map_data("world")
ggplot() +
  geom_map(data = world_map, map = world_map, aes(x = long, y = lat, map_id = region), 
           color = "black", fill = "lightgray", size = 0.2) +
  
  
  geom_density2d(data = meteorite_dataset, aes(x = reclong, y = reclat), color = "red", size = 0.5) +
  
  stat_density2d(data = meteorite_dataset, aes(x = reclong, y = reclat, fill = ..density..), 
                 geom = "raster", contour = FALSE, alpha = 0.3) +  
  scale_fill_gradient(low = "white", high = "red") +  
  
  
  labs(title = "Density-Based Heatmap of Meteorite Locations",
       x = "Longitude",
       y = "Latitude") +
  theme_minimal() +
  coord_fixed(ratio = 1.1)  

################ TIME SERIES PLOT 
ggplot(meteorite_counts, aes(x = year, y = count)) +
  geom_line(color = "black", size = 1) +  
  geom_point(color = "red", size = 1.5) +  
  labs(title = "Meteorite Discoveries Over Time",
       x = "Year",
       y = "Number of Discoveries") +
  theme_minimal()  

################ BOX PLOT MASS 
ggplot(meteorite_dataset, aes(y = mass)) +
  geom_boxplot(color = "black", fill = "gray") +  
  scale_y_log10() +  # Logarithmic scale for mass
  labs(title = "Boxplot of Meteorite Mass (Log Scale)", y = "Mass (log10 scale)") +
  theme_minimal()

############### FELL_FOUND GRAPH 
ggplot(Fell_Found_Freq, aes(x = fall, y = n, fill = fall)) +
  geom_bar(stat = "identity") +
  labs(title = "Comparison of Fell vs Found Meteorites",
       x = "Meteorite Type",
       y = "Count") +
  theme_minimal()

################ PIECHART FOR METEORITE RECLASSIFICATION
categories <- c("L6", "H5", "H4", "H6", "L5", "LL5", "LL6", "Iron", "L4", "H4/5")
values <- c(6577, 5607, 3335, 3232, 2744, 1897, 964, 928, 801, 380)
sorted_indices <- order(values, decreasing = TRUE)
categories <- categories[sorted_indices]
values <- values[sorted_indices]
legend_labels <- paste(categories, values)  # Shows both category and value
pie_labels <- categories  # Shows only category names
pie(values, labels = pie_labels, 
    main = "Piechart showing meteorite reclassification", 
    col = rainbow(length(categories)))
legend("topright", legend = legend_labels, fill = rainbow(length(categories)), cex = 0.8) 
