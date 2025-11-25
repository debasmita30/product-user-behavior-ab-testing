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

This **PowerBI** dashboard includes:
Page 1 — 
A/B Testing & Funnel Performance

<img width="1762" height="697" alt="image" src="https://github.com/user-attachments/assets/8a4051af-f58c-465a-b53f-4f5a046bee99" />



Page 2 — Funnel Analysis & Stage Efficiency

<img width="1764" height="701" alt="image" src="https://github.com/user-attachments/assets/d622ed6d-7af6-4d0b-abed-666d1e11ce00" />


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


SQL Queries Used in This Project


These SQL queries illustrate how user-behavior datasets can be processed, aggregated, and analyzed in a realistic Data Science workflow. They match the project’s A/B testing, funnel modeling, and segmentation logic.

1. Create Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    persona VARCHAR(50),
    signup_date DATE
);

2. Create Sessions Table
CREATE TABLE sessions (
    session_id INT PRIMARY KEY,
    user_id INT,
    variant CHAR(1),
    session_duration INT,
    pages_visited INT,
    interacted_with_panel INT,
    engaged INT,
    added_to_cart INT,
    converted INT,
    engagement_score FLOAT,
    time_to_conversion FLOAT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

3. Join Users and Sessions

Useful for combined persona + behavior analysis.

SELECT 
    s.session_id,
    s.user_id,
    u.persona,
    u.signup_date,
    s.variant,
    s.session_duration,
    s.pages_visited,
    s.engagement_score,
    s.converted
FROM sessions s
JOIN users u
    ON s.user_id = u.user_id;

4. Funnel Stage Counts

Equivalent to your R + Power BI funnel metrics.

SELECT
    COUNT(*) AS visits,
    SUM(CASE WHEN engaged = 1 THEN 1 END) AS engaged,
    SUM(CASE WHEN added_to_cart = 1 THEN 1 END) AS added_to_cart,
    SUM(CASE WHEN converted = 1 THEN 1 END) AS conversions
FROM sessions;

5. Variant-Level Funnel Metrics

Used to compare A vs B at each funnel step.

SELECT
    variant,
    COUNT(*) AS visits,
    SUM(CASE WHEN engaged = 1 THEN 1 END) AS engaged,
    SUM(CASE WHEN added_to_cart = 1 THEN 1 END) AS added_to_cart,
    SUM(CASE WHEN converted = 1 THEN 1 END) AS conversions
FROM sessions
GROUP BY variant;

6. Conversion Rate by Variant

Matches your pA / pB calculations in R.

SELECT
    variant,
    ROUND(AVG(converted), 4) AS conversion_rate
FROM sessions
GROUP BY variant;

7. Persona-Level Drop-Off Analysis

This powers your Persona Funnel Chart on Page-2.

SELECT
    persona,
    ROUND(SUM(CASE WHEN engaged = 1 THEN 1 END) * 1.0 / COUNT(*), 3) AS visit_to_engage,
    ROUND(SUM(CASE WHEN added_to_cart = 1 THEN 1 END) * 1.0 / SUM(engaged), 3) AS engage_to_cart,
    ROUND(SUM(CASE WHEN converted = 1 THEN 1 END) * 1.0 / SUM(added_to_cart), 3) AS cart_to_conversion
FROM sessions
JOIN users USING (user_id)
GROUP BY persona;

8. Identify High-Intent Power Users

Example of how product teams filter strong-conversion personas.

SELECT
    user_id,
    persona,
    COUNT(*) AS total_sessions,
    AVG(session_duration) AS avg_duration,
    SUM(converted) AS conversions
FROM sessions
JOIN users USING (user_id)
GROUP BY user_id, persona
HAVING SUM(converted) > 0;

9. Time-to-Conversion Insights

Matches Page-3’s time analytics.

SELECT
    variant,
    AVG(time_to_conversion) AS avg_time_to_convert,
    MIN(time_to_conversion) AS fastest_conversion,
    MAX(time_to_conversion) AS slowest_conversion
FROM sessions
WHERE converted = 1
GROUP BY variant;

10. Interaction Impact on Conversion

This supports the “Panel Interaction → Conversion Lift” visual.

SELECT
    interacted_with_panel,
    ROUND(AVG(converted), 4) AS conversion_rate
FROM sessions
GROUP BY interacted_with_panel;







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
