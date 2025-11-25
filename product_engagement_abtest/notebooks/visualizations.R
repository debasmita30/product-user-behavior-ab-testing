library(ggplot2)
conv_plot <- sessions %>%group_by(variant) %>%summarise(conv_rate = mean(conversion))

ggplot(conv_plot, aes(x = variant, y = conv_rate, fill = variant)) +geom_col(width = 0.6) +labs(title = "Conversion Rate by Variant",x = "Variant",y = "Conversion Rate") +scale_y_continuous(labels = scales::percent_format()) +theme_minimal()


ggplot(sessions, aes(x = engagement_score, fill = variant)) +
  geom_density(alpha = 0.4) +
  labs(title = "Engagement Score Distribution by Variant",x = "Engagement Score") +
  theme_minimal()


persona_conv <- sessions %>%
  group_by(persona, variant) %>%
  summarise(conv_rate = mean(conversion))

ggplot(persona_conv, aes(x = persona, y = conv_rate, fill = variant)) +
  geom_col(position = "dodge") +
  labs(title = "Persona-wise Conversion Rate by Variant",
       y = "Conversion Rate") +
  scale_y_continuous(labels = scales::percent_format()) +
  theme_minimal()



funnel_plot <- sessions %>%
  group_by(variant) %>%
  summarise(
    visit = n(),
    engage = sum(engaged),
    cart = sum(add_to_cart),
    conversion = sum(conversion)
  ) %>%
  tidyr::pivot_longer(cols = c(visit, engage, cart, conversion),
                      names_to = "stage",
                      values_to = "count")

ggplot(funnel_plot, aes(x = stage, y = count, fill = variant)) +
  geom_col(position = "dodge") +
  labs(title = "Funnel Stages by Variant",
       y = "Number of Users") +
  theme_minimal()



uplift_df <- data.frame(
  variant = c("A", "B"),
  conv_rate = c(pA, pB)
)

ggplot(uplift_df, aes(x = variant, y = conv_rate, fill = variant)) +
  geom_col() +
  geom_text(aes(label = paste0(round(conv_rate*100, 3), "%")), vjust = -0.5) +
  labs(title = "A/B Conversion Rate Comparison",
       y = "Conversion Rate") +
  scale_y_continuous(labels = scales::percent_format()) +
  theme_minimal()

