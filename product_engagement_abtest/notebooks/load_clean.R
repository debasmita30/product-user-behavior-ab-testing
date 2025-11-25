library(dplyr)
library(readr)
library(lubridate)
users <- read_csv("data/users.csv")
sessions <- read_csv("data/sessions.csv")
str(users)
str(sessions)
head(users)
head(sessions)
sessions_clean <- sessions %>%
  mutate(
    persona = as.factor(persona),
    variant = as.factor(variant),
    interacted_with_panel = as.integer(interacted_with_panel),
    engaged = as.integer(engaged),
    added_to_cart = as.integer(added_to_cart),
    converted = as.integer(converted)
  )

write_csv(sessions_clean, "data/sessions_clean.csv")
