library(dplyr)
library(readr)
library(lubridate)

sessions <- read_csv("data/sessions_clean.csv")
users <- read_csv("data/users.csv")
sessions <- sessions %>%mutate(session_depth = pages_visited * (1 + interacted_with_panel))
sessions <- sessions %>%mutate(engagement_level = case_when(engagement_score < 50 ~ "Low",engagement_score < 150 ~ "Medium",TRUE ~ "High"))
sessions <- sessions %>%mutate(visited = 1,engaged = as.integer(engaged),add_to_cart = as.integer(added_to_cart),conversion = as.integer(converted))
funnel_summary <- sessions %>%
  group_by(variant) %>%
  summarise(
    visits = n(),
    engages = sum(engaged),
    add_to_carts = sum(add_to_cart),
    conversions = sum(conversion),
    visit_to_engage = engages / visits,
    engage_to_cart = add_to_carts / engages,
    cart_to_conversion = conversions / add_to_carts,
    total_conversion_rate = conversions / visits
  )
funnel_summary

persona_summary <- sessions %>%
  group_by(persona, variant) %>%
  summarise(
    sessions = n(),
    avg_session_duration = mean(session_duration),
    avg_engagement_score = mean(engagement_score),
    panel_interaction_rate = mean(interacted_with_panel),
    conversion_rate = mean(conversion)
  )

persona_summary
install.packages("ggplot2")
library(ggplot2)
ggplot(sessions, aes(x = engagement_score, fill = variant)) +
  geom_density(alpha = 0.4) +
  labs(title = "Engagement Score Distribution by Variant")


ggplot(sessions, aes(x = variant, y = conversion)) +
  stat_summary(fun = mean, geom = "bar") +
  labs(title = "Conversion Rate by Variant")

write_csv(sessions, "data/sessions_features.csv")


library(dplyr)
library(readr)

sessions <- read_csv("data/sessions_features.csv")


agg <- sessions %>%
  group_by(variant) %>%
  summarise(
    n = n(),
    conversions = sum(conversion),
    conversion_rate = mean(conversion)
  )
agg


nA <- agg$n[agg$variant == "A"]
nB <- agg$n[agg$variant == "B"]
xA <- agg$conversions[agg$variant == "A"]
xB <- agg$conversions[agg$variant == "B"]
prop.test(c(xA, xB), c(nA, nB), correct = FALSE)


pA <- 0.006014499
pB <- 0.008234916
uplift <- pB - pA
nA <- agg$n[agg$variant == "A"]
nB <- agg$n[agg$variant == "B"]
se <- sqrt(pA*(1-pA)/nA + pB*(1-pB)/nB)

ci_lower <- uplift - 1.96 * se
ci_upper <- uplift + 1.96 * se
c(uplift = uplift, CI_lower = ci_lower, CI_upper = ci_upper)

table_interaction <- table(sessions$variant, sessions$interacted_with_panel)
chisq.test(table_interaction)

t.test(session_duration ~ variant, data = sessions)
