# This file is purely as an example.
# Note, you may end up creating more than one cleaned data set and saving that
# to separate files in order to work on different aspects of your project

library(tidyverse)

loan_data <- read_csv(here::here("dataset", "loan_refusal.csv"))

## CLEAN the data
loan_data_clean <- loan_data |>
  pivot_longer(2:5, names_to = "group", values_to = "refusal_rate")

write_rds(loan_data_clean, file = here::here("dataset", "loan_refusal_clean.rds"))
