set.seed(2025)
library(dplyr)
library(lubridate)

n_users <- 15000
personas <- c("Explorer","TargetedShopper","DealHunter","HighIntent")
users <- tibble(
  user_id = seq_len(n_users),
  persona = sample(personas, n_users, replace = TRUE, prob = c(0.35,0.30,0.25,0.10)),
  signup_date = sample(seq(as.Date("2024-01-01"), as.Date("2025-10-31"), by="day"), n_users, replace = TRUE)
)

n_sessions <- 50000
sessions <- tibble(
  session_id = seq_len(n_sessions),
  user_id = sample(users$user_id, n_sessions, replace = TRUE),
  variant = sample(c("A","B"), n_sessions, replace = TRUE, prob = c(0.5,0.5)),
  session_duration = round(rlnorm(n_sessions, meanlog = 4.2, sdlog = 0.8)),
  pages_visited = rpois(n_sessions, lambda = 5)
) %>%
  left_join(users %>% select(user_id, persona), by = "user_id")

sessions <- sessions %>%
  mutate(
    base_interact = case_when(
      persona == "Explorer" ~ 0.05,
      persona == "TargetedShopper" ~ 0.15,
      persona == "DealHunter" ~ 0.18,
      persona == "HighIntent" ~ 0.30
    ),
    variant_boost = ifelse(variant == "B", 0.07, 0),
    interacted_with_panel = rbinom(n(), 1, pmin(0.95, base_interact + variant_boost))
  )

sessions <- sessions %>%
  rowwise() %>%
  mutate(
    p_engage = pmin(0.9, 0.1 + 0.02*pages_visited + 0.3*interacted_with_panel),
    engaged = rbinom(1,1,p_engage),
    p_add = ifelse(engaged==1, pmin(0.8, 0.05 + 0.2*interacted_with_panel),0),
    added_to_cart = rbinom(1,1,p_add),
    p_conv = ifelse(added_to_cart==1, pmin(0.6, 0.02 + 0.3*interacted_with_panel),0),
    converted = rbinom(1,1,p_conv)
  ) %>%
  ungroup()

sessions <- sessions %>%
  mutate(
    engagement_score = pages_visited * (session_duration / 60) * (1 + interacted_with_panel),
    time_to_conversion = ifelse(converted==1, runif(n(), 30, session_duration), NA)
  )

library(dplyr)

pA <- sessions %>%
  filter(variant == "A") %>%
  summarise(conv_rate = mean(converted)) %>%
  pull(conv_rate)

pB <- sessions %>%
  filter(variant == "B") %>%
  summarise(conv_rate = mean(converted)) %>%
  pull(conv_rate)

pA; pB

dir.create("data", showWarnings = FALSE)
write.csv(users, "data/users.csv", row.names = FALSE)
write.csv(sessions, "data/sessions.csv", row.names = FALSE)


