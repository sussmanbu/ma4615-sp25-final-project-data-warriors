# This file is purely as an example.
# Note, you may end up creating more than one cleaned data set and saving that
# to separate files in order to work on different aspects of your project

library(tidyverse)


demographic_data <- read_csv(here::here("dataset", "demographic_data.csv")) 

write_rds(demographic_data, file = here::here("dataset", "demographic_data.rds"))

pollution_data <- read_csv(here::here("dataset", "pollution_data.csv"), show_col_types = FALSE)

#remove columns from pollution dataset that already exist in the demographic dataset
pollution_data <- pollution_data |> 
                    select(-c('Total Population', 'California County', 'CES 4.0 Score', 
                              'CES 4.0 Percentile', 'CES 4.0 Percentile Range'))

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
  cleaned_dataset <- cleaned_dataset |>
    select(-contains(pattern))
}

# Seeing how many Null values within dataset and dropping them
colSums(is.na(cleaned_dataset)) # seems like Low birth has the largest amount of
# missing values, should we still drop everything?
cleaned_dataset <- cleaned_dataset |>
  drop_na()

# Writing RDS
write_rds(cleaned_dataset, file = here::here("dataset", "cleaned_dataset.rds"))


