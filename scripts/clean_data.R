# This file is purely as an example.
# Note, you may end up creating more than one cleaned data set and saving that
# to separate files in order to work on different aspects of your project

library(tidyverse)
library(tidymodels)


demographic_data <- read_csv(here::here("dataset", "demographic_data.csv")) 

write_rds(demographic_data, file = here::here("dataset", "demographic_data.rds"))

pollution_data <- read_csv(here::here("dataset", "pollution_data.csv"), show_col_types = FALSE)

#remove columns from demographic dataset that already exist in the pollution dataset
demographic_data <- demographic_data |> 
                    select(-c('Total Population', 'California County', 'CES 4.0 Score', 
                              'CES 4.0 Percentile', 'CES 4.0 Percentile Range'))

write_rds(pollution_data, file = here::here("dataset", "pollution_data.rds"))

# Join demographic data to pollution data
cleaned_dataset <- left_join(pollution_data, demographic_data, by ="Census Tract")

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

# convert character columns to factors 
cleaned_dataset <- cleaned_dataset |>
  mutate(across(where(is.character), as.factor))

# Impute any null values using KNN approach 
pollution_recipe <- recipe(~ ., data = cleaned_dataset) |>
  step_impute_knn(all_predictors(), , neighbors = 3)

prepared_recipe <- prep(pollution_recipe)

imputed_data <- bake(prepared_recipe, cleaned_dataset)

# Writing RDS
write_rds(imputed_data, file = here::here("dataset", "cleaned_dataset.rds"))




