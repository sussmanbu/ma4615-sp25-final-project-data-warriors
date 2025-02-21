# This file is purely as an example.

library(tidyverse)

loan_data <- read_rds(here::here("dataset", "loan_refusal_clean.rds")) |>
  filter(group == "min")


write_rds(loan_data, file = here::here("dataset_for_shiny", "loan_refusal_shiny.rds"))
