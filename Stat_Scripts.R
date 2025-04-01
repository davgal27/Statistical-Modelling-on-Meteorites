############## FUNCTION TO COMPUTE SUMMARY STATISTICS 
library(e1071)
compute_summary_stats <- function(dataset, columns) {
  summary_stats_rounded <- sapply(dataset[, columns], function(x) {
    stats <- c(
      Min = min(x),
      "1st Quartile" = quantile(x, 0.25),
      Median = median(x),
      Mean = mean(x),
      "3rd Quartile" = quantile(x, 0.75),
      Max = max(x),
      "Standard Deviation" = sd(x),  # Add standard deviation
      "Interquartile Range" = IQR(x)  # Calculate and add IQR (Q3 - Q1)
    )
    formatted_stats <- sprintf("%.3f", stats)
    names(formatted_stats) <- names(stats)
    formatted_stats
  })
  
  return(summary_stats_rounded)
}

summary_stats_result <- compute_summary_stats(meteorite_dataset, c("mass", "year", "reclat", "reclong"))
summary_stats_result

############ METEORITE COUNTS 
meteorite_counts <- meteorite_dataset %>%
  group_by(year) %>%
  summarise(count = n())


############ SKEWNESS 
print("Skewness Results:")
print(skewness(meteorite_dataset$mass))
print(skewness(meteorite_dataset$year))
print(skewness(meteorite_dataset$reclat))
print(skewness(meteorite_dataset$reclong))

########## KURTOSIS 
print("Kurtosis Results:")
print(kurtosis(meteorite_dataset$mass))
print(kurtosis(meteorite_dataset$year))
print(kurtosis(meteorite_dataset$reclat))
print(kurtosis(meteorite_dataset$reclong))
