## Product Engagement Optimization via User Behavior Analytics & A/B Testing

A Data Science + Product Analytics Project using R, Power BI, SQL concepts, and A/B Testing

**Overview :-**

This project analyzes how a new Smart Recommendation Panel impacts user engagement, funnel performance, and conversion behavior.
It simulates 50,000+ user sessions using R and builds a multi-page Power BI dashboard for deep product insights.
It combines:
R (for data simulation + preprocessing)
Power BI (for dashboarding & visualization)
A/B Testing (Variant A vs Variant B)
User Personas (Explorer, Deal Hunter, Targeted Shopper, High Intent)
Funnel Analysis (Visit → Engage → Cart → Convert)

The goal: identify whether the new recommendation panel improves user engagement and conversions, and highlight key behavioral patterns across personas.

**Live Dashboard
🔗 Add your link here after publishing from Power BI Service.**

This dashboard includes:
Page 1 — A/B Testing & Funnel Performance

Conversion uplift
Interaction impact
Variant comparison
Conversion waterfall
Key experiment insights

Page 2 — Funnel Analysis & Stage Efficiency

Funnel shape visualization
Variant drop-off analysis
Stage-wise conversion efficiency
Persona drop-off segmentation
Key bottleneck insights

Screenshots of the Visualizations(R Studio):-

### Conversion Rate Analysis (R Code)
I used ggplot2 to visualize the performance difference between Variant A and B.

```r
library(ggplot2)
conv_plot <- sessions %>% 
  group_by(variant) %>% 
  summarise(conv_rate = mean(conversion))

ggplot(conv_plot, aes(x = variant, y = conv_rate, fill = variant)) +
  geom_col(width = 0.6) +
  labs(title = "Conversion Rate by Variant",
       x = "Variant", 
       y = "Conversion Rate") +
  scale_y_continuous(labels = scales::percent_format()) +
  theme_minimal()
```
<img width="1913" height="1008" alt="image" src="https://github.com/user-attachments/assets/b3b6a712-6a5b-4e01-a599-007a1f6d07f5" />
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Engagement Score Distribution (R Code)
I used a Density Plot to analyze the shape of user engagement. The visualization reveals a heavy right-skew, showing that while most users have low interaction scores, there is a "long tail" of highly engaged power users.

# Visualizing the distribution shape using a Density Plot

```r
library(ggplot2)
ggplot(sessions, aes(x = engagement_score, fill = variant)) +
  geom_density(alpha = 0.4) + # Alpha sets transparency to see overlaps
  labs(title = "Engagement Score Distribution by Variant",
       x = "Engagement Score",
       y = "Density") +
  theme_minimal()
```

<img width="1909" height="1011" alt="image" src="https://github.com/user-attachments/assets/b26a6c32-176e-41d2-9712-2e1f6af984d2" />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Persona-Level Conversion Analysis
I segmented the data by user persona to see if the new variant worked better for specific user types (e.g., Explorers vs. High Intent users).


```r
persona_conv <- sessions %>%
  group_by(persona, variant) %>%
  summarise(conv_rate = mean(conversion))

ggplot(persona_conv, aes(x = persona, y = conv_rate, fill = variant)) +
  geom_col(position = "dodge") +
  labs(title = "Persona-wise Conversion Rate by Variant",
       y = "Conversion Rate") +
  scale_y_continuous(labels = scales::percent_format()) +
  theme_minimal()
```
<img width="1907" height="1012" alt="image" src="https://github.com/user-attachments/assets/bab6b463-9fad-48f7-be59-4d021c326dce" />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Funnel Stage Analysis (Data Wrangling)
To visualize the drop-off at every stage, I first summarized the data and then used tidyr::pivot_longer to reshape the data from wide to long format for plotting.


```r
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
```
<img width="1910" height="1008" alt="image" src="https://github.com/user-attachments/assets/74bcfa4a-e3ba-464c-9322-020e71d5ddb2" />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Final A/B Uplift Visualization
This chart visualizes the final result of the experiment, adding dynamic text labels to clearly show the exact percentage difference between Control (A) and Test (B).

```r

# pA and pB are the calculated conversion rates for each variant
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
```
<img width="1908" height="1009" alt="image" src="https://github.com/user-attachments/assets/04b0c01b-320d-46d0-8928-886cc452085f" />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Repository Structure
📦 user-behavior-ab-testing
│
├── data/
│   ├── users.csv
│   ├── sessions.csv
│   ├── sessions_clean.csv
│   └── sessions_features.csv
│
├── r-code/
│   ├── data_simulation.R
│   └── funnel_feature_engineering.R
│
├── screenshots/
│   ├── page1_dashboard.png
│   ├── page2_dashboard.png
│   └── insights.png
│
├── PowerBI/
│   └── A_B_Test_Dashboard.pbix
│
└── README.md


Experiment Design
The experiment tests whether a new Smart Recommendation Panel (Variant B) increases:

User engagement

Add-to-cart activity

Conversion probability

Time-to-conversion efficiency

Personas simulated:
Explorer

Deal Hunter

Targeted Shopper

High Intent

🧮 R Workflow
1. Simulate Users
  users <- tibble(
  user_id = 1:15000,
  persona = sample(personas, 15000, replace = TRUE),
  signup_date = sample(seq(as.Date('2024-01-01'), as.Date('2025-10-31'), by = "day"), 15000, replace = TRUE)
)

2. Simulate Sessions

     Includes:
  
     session_duration
  
     pages_visited
  
     persona-driven interaction probability
  
     variant boosts
  
     funnel probabilities (engage → cart → convert)

3. Feature Engineering
   
     engagement_score
   
     time_to_conversion
   
     high-engagement buckets
   
     funnel stage flags

📊 Power BI Dashboard Features
✔ Variant A vs B conversion efficiency
✔ Funnel drop-off analysis
✔ Persona funnel segmentation
✔ Stage-wise conversion efficiency (A vs B)
✔ Interaction impact on conversion
✔ Dynamic slicers (Variant, Persona, Session Duration)


🔍 Key Insights From the Data

Variant B consistently outperforms Variant A across funnel stages.
The largest bottleneck occurs at Engage → Cart, making it the highest leverage optimization area.
High Intent and Deal Hunters show the highest funnel efficiency.
Panel interaction strongly increases conversion likelihood.

Installation
Clone the repo:
git clone https://github.com/<your-username>/<repo-name>.git

Open R scripts:

Use RStudio to run:

r-code/data_simulation.R
and
r-code/funnel_feature_engineering.R

Open Power BI dashboard:
PowerBI/A_B_Test_Dashboard.pbix
