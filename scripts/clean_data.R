# This file is purely as an example.
# Note, you may end up creating more than one cleaned data set and saving that
# to separate files in order to work on different aspects of your project

library(tidyverse)
library(dplyr)


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

# Merging demographic data to pollution data
cleaned_dataset <- merge(pollution_data, demographic_data,by = "Census Tract", all.x = TRUE)

# Removing Columns
columns_to_remove_patterns <- c(
  "Drinking Water", "Lead", "Pesticides", "Groundwater Threats", 
  "Imp. Water Bodies", "Education", "Linguistic Isolation", 
  "Poverty", "Unemployment", "Housing Burden"
)

# Remove the columns
for (pattern in columns_to_remove_patterns) {
  cleaned_dataset <- cleaned_dataset %>%
    select(-contains(pattern))
}

# Writing RDS
write_rds(cleaned_dataset, file = here::here("dataset", "cleaned_dataset.rds"))

