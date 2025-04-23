# This file is purely as an example.

library(tidyverse)

loan_data <- read_rds(here::here("dataset", "loan_refusal_clean.rds")) |>
  filter(group == "min")
write_rds(loan_data, file = here::here("dataset_for_shiny", "loan_refusal_shiny.rds"))


cleaned_data <- read_rds(here::here("dataset", "cleaned_dataset.rds")) 
county_demographic <- cleaned_data |>
  select(
    `California County`, `Pollution Burden Score`,
    `Hispanic (%)`, `White (%)`, `African American (%)`,
    `Asian American (%)`, `Native American (%)`, `Other/Multiple (%)`
  )
write_rds(county_demographic, file = here::here("dataset_for_shiny", "county_demographic.rds"))

