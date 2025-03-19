# This file is purely as an example.
# Note, you may end up creating more than one cleaned data set and saving that
# to separate files in order to work on different aspects of your project

library(tidyverse)


demographic_data <- read_csv(here::here("dataset", "demographic_data.csv")) 

## CLEAN the data
##loan_data_clean <- loan_data |>
  ##pivot_longer(2:5, names_to = "group", values_to = "refusal_rate")

write_rds(demographic_data, file = here::here("dataset", "demographic_data.rds"))

pollution_data <- read_csv(here::here("dataset", "pollution_data.csv"), show_col_types = FALSE)

## CLEAN the data
##loan_data_clean <- loan_data |>
##pivot_longer(2:5, names_to = "group", values_to = "refusal_rate")

write_rds(pollution_data, file = here::here("dataset", "pollution_data.rds"))

cleaned_dataset <- merge(pollution_data, demographic_data,by = "Census Tract", all.x = TRUE)
print (cleaned_dataset)

write_rds(cleaned_dataset, file = here::here("dataset", "cleaned_dataset.rds"))
