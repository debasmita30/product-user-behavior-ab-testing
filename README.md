<div align="center">

# 🧪 Product Engagement Optimization
### via User Behavior Analytics & A/B Testing

<br/>

<img src="https://img.shields.io/badge/R-Data%20Simulation-276DC3?style=for-the-badge&logo=r&logoColor=white"/>
<img src="https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black"/>
<img src="https://img.shields.io/badge/A%2FB-Testing-FF6B6B?style=for-the-badge"/>
<img src="https://img.shields.io/badge/SQL-Analytics-4479A1?style=for-the-badge&logo=postgresql&logoColor=white"/>
<img src="https://img.shields.io/badge/Users-50,000+%20Sessions-22C55E?style=for-the-badge"/>

<br/><br/>

> **Simulate · Analyze · Decide** — does the Smart Recommendation Panel actually move the needle?

<br/>

[![Live Dashboard](https://img.shields.io/badge/📊%20Live%20Power%20BI%20Dashboard-Open%20Now-F2C811?style=for-the-badge)](https://app.powerbi.com/view?r=eyJrIjoiNDBjMTYyYmMtMWI2YS00MTUyLWJiMWQtNzM3YmMxOGNmMWMyIiwidCI6ImUxNGU3M2ViLTUyNTEtNDM4OC04ZDY3LThmOWYyZTJkNWE0NiIsImMiOjEwfQ%3D%3D)

</div>

---

## ❓ Problem Statement

E-commerce and SaaS platforms constantly ship new features, but without rigorous measurement, teams can't answer the questions that matter most:

| Business Question | Without This Project | Consequence |
|---|---|---|
| *Does the new panel improve engagement?* | Gut-feel decisions | Features shipped with no ROI proof |
| *Where do users drop out of the funnel?* | No stage-level visibility | Highest-leverage fix areas stay unknown |
| *Which user personas respond to the panel?* | Averaged-out data hides segments | Personalization strategy is guesswork |
| *Does panel interaction actually drive conversion?* | Correlation assumed, not tested | Budget mis-allocated to low-impact UI |
| *How quickly do converted users decide?* | Time-to-convert unknown | Pricing and urgency signals untested |

```
  50,000+ user sessions    ─────────────►   ❌ No structured insight
  across Variant A & B
                                  ▲
      No controlled experiment   → can't isolate the panel's effect
      No funnel decomposition    → drop-off points invisible
      No persona segmentation    → one-size-fits-all conclusions
      No statistical testing     → "feels better" isn't evidence
```

---

## ✅ Solution

A fully simulated, end-to-end **A/B testing and behavioral analytics pipeline** that answers every question above with data.

```
  ┌─────────────────────────────────────────────────────────────────┐
  │                     SOLUTION AT A GLANCE                         │
  ├─────────────────────────────────────────────────────────────────┤
  │                                                                  │
  │  SIMULATE  →  50,000+ realistic sessions in R across           │
  │               4 user personas and 2 variants                    │
  │                                                                  │
  │  ENGINEER  →  Funnel flags, engagement scores,                  │
  │               time-to-conversion, high-engagement buckets       │
  │                                                                  │
  │  TEST      →  Controlled A/B experiment — Variant A (control)   │
  │               vs Variant B (Smart Recommendation Panel)         │
  │                                                                  │
  │  ANALYZE   →  Funnel drop-off, persona segmentation,            │
  │               panel interaction lift, conversion uplift         │
  │                                                                  │
  │  SERVE     →  Multi-page Power BI dashboard with dynamic        │
  │               slicers for variant, persona, session duration    │
  │                                                                  │
  └─────────────────────────────────────────────────────────────────┘
```

| Design Decision | Rationale |
|---|---|
| **R for simulation** | Fine-grained control over persona-driven probability distributions |
| **A/B split at session level** | Isolates panel effect from user-level confounders |
| **4 distinct personas** | Captures real behavioral heterogeneity; prevents averaged-out conclusions |
| **Funnel decomposition** | Pinpoints exact drop-off stage rather than just final conversion rate |
| **Power BI for delivery** | Shareable, filterable dashboard accessible to non-technical stakeholders |

---

## 🏛️ System Architecture

```
╔═════════════════════════════════════════════════════════════════════════╗
║           PRODUCT ENGAGEMENT OPTIMIZATION — SYSTEM ARCHITECTURE         ║
╚═════════════════════════════════════════════════════════════════════════╝

  ┌──────────────────────────────────────┐
  │   1️⃣  DATA SIMULATION  (R)           │
  │  ──────────────────────────────────  │
  │  data_simulation.R                   │
  │                                      │
  │  15,000 users × 4 personas           │
  │  ┌──────────────┬───────────────┐   │
  │  │   Explorer   │  Deal Hunter  │   │
  │  ├──────────────┼───────────────┤   │
  │  │  Targeted    │  High Intent  │   │
  │  │  Shopper     │               │   │
  │  └──────────────┴───────────────┘   │
  │                                      │
  │  Variant A (Control)                 │
  │  Variant B (Smart Panel) ← test      │
  └─────────────────┬────────────────────┘
                    │  users.csv  ·  sessions.csv
                    ▼
  ┌──────────────────────────────────────┐
  │   2️⃣  FEATURE ENGINEERING  (R)       │
  │  ──────────────────────────────────  │
  │  funnel_feature_engineering.R        │
  │                                      │
  │  • engagement_score                  │
  │  • time_to_conversion                │
  │  • high_engagement flag              │
  │  • funnel stage flags                │
  │    visit → engage → cart → convert   │
  └─────────────────┬────────────────────┘
                    │  sessions_clean.csv
                    │  sessions_features.csv
                    ▼
  ┌──────────────────────────────────────┐        ┌──────────────────────┐
  │   3️⃣  SQL ANALYTICS LAYER            │        │   Relational Schema  │
  │  ──────────────────────────────────  │        │  ──────────────────  │
  │  Funnel aggregations                 │        │  ┌───────┐           │
  │  Variant-level drop-off              │◄───────│  │ users │           │
  │  Persona segmentation                │        │  └───┬───┘           │
  │  Panel interaction lift              │        │      │ 1:N           │
  │  Time-to-conversion stats            │        │  ┌───▼──────────┐   │
  └─────────────────┬────────────────────┘        │  │   sessions   │   │
                    │                              │  └──────────────┘   │
                    ▼                              └──────────────────────┘
  ┌────────────────────────────────────────────────────────────────────┐
  │   4️⃣  POWER BI DASHBOARD  (2 pages)                               │
  │  ────────────────────────────────────────────────────────────────  │
  │                                                                    │
  │  Page 1 · A/B Testing & Funnel Performance                        │
  │  ┌──────────────────────────────────────────────────────────────┐ │
  │  │  Variant A vs B conversion · Funnel bar charts               │ │
  │  │  Engagement distribution · Uplift KPI cards                  │ │
  │  └──────────────────────────────────────────────────────────────┘ │
  │                                                                    │
  │  Page 2 · Funnel Analysis & Stage Efficiency                      │
  │  ┌──────────────────────────────────────────────────────────────┐ │
  │  │  Persona funnel breakdown · Stage drop-off rates             │ │
  │  │  Panel interaction → conversion lift · Time analytics        │ │
  │  └──────────────────────────────────────────────────────────────┘ │
  │                                                                    │
  │  Slicers: Variant  ·  Persona  ·  Session Duration               │
  └────────────────────────────────────────────────────────────────────┘
```

---

## 🧠 Overview

This project analyzes how a **Smart Recommendation Panel** impacts user engagement, funnel performance, and conversion behavior. It simulates **50,000+ user sessions** using R and builds a multi-page Power BI dashboard for deep product insights.

```
  R simulation          Power BI              A/B Testing
  + preprocessing  →    dashboarding     +    Variant A vs B
        │                                           │
        └───────────────────────────────────────────┘
                              │
              ┌───────────────┼───────────────┐
              ▼               ▼               ▼
        User Personas    Funnel Analysis   Conversion
        (4 segments)     Visit→Convert     Uplift
```

---

## 📊 Live Power BI Dashboard

🔗 **[Open Dashboard →](https://app.powerbi.com/view?r=eyJrIjoiNDBjMTYyYmMtMWI2YS00MTUyLWJiMWQtNzM3YmMxOGNmMWMyIiwidCI6ImUxNGU3M2ViLTUyNTEtNDM4OC04ZDY3LThmOWYyZTJkNWE0NiIsImMiOjEwfQ%3D%3D)**

### Page 1 — A/B Testing & Funnel Performance

<img width="1762" height="697" alt="image" src="https://github.com/user-attachments/assets/8a4051af-f58c-465a-b53f-4f5a046bee99" />

### Page 2 — Funnel Analysis & Stage Efficiency

<img width="1764" height="701" alt="image" src="https://github.com/user-attachments/assets/d622ed6d-7af6-4d0b-abed-666d1e11ce00" />

---

## 🧪 Experiment Design

The experiment tests whether the **Smart Recommendation Panel (Variant B)** increases:

```
  ┌──────────────────────────────────────────────────────┐
  │  WHAT WE'RE MEASURING                                 │
  ├──────────────────────────────────────────────────────┤
  │  ✦  User engagement score                            │
  │  ✦  Add-to-cart activity                             │
  │  ✦  Conversion probability                           │
  │  ✦  Time-to-conversion efficiency                    │
  └──────────────────────────────────────────────────────┘

  Personas simulated:
  ┌─────────────────┬──────────────────────────────────┐
  │  🔍 Explorer     │  Browses widely, low intent      │
  │  🏷️ Deal Hunter  │  Motivated by offers & discounts │
  │  🎯 Targeted     │  Knows what they want            │
  │  ⚡ High Intent  │  Ready to convert quickly        │
  └─────────────────┴──────────────────────────────────┘
```

---

## 🧮 R Workflow

### Step 1 — Simulate Users

```r
users <- tibble(
  user_id = 1:15000,
  persona = sample(personas, 15000, replace = TRUE),
  signup_date = sample(seq(as.Date('2024-01-01'), as.Date('2025-10-31'), by = "day"),
                       15000, replace = TRUE)
)
```

### Step 2 — Simulate Sessions

Sessions include persona-driven interaction probabilities and variant boosts:

```
  session_duration  ·  pages_visited  ·  interacted_with_panel
  engaged  ·  add_to_cart  ·  conversion  ·  funnel stage flags
```

### Step 3 — Feature Engineering

```r
# funnel_feature_engineering.R
engagement_score        ← composite behavioral signal
time_to_conversion      ← minutes from visit to purchase
high_engagement bucket  ← flag for power users
funnel stage flags      ← visit → engage → cart → convert
```

---

## 📈 R Visualizations

### Conversion Rate by Variant

```r
library(ggplot2)
conv_plot <- sessions %>% 
  group_by(variant) %>% 
  summarise(conv_rate = mean(conversion))

ggplot(conv_plot, aes(x = variant, y = conv_rate, fill = variant)) +
  geom_col(width = 0.6) +
  labs(title = "Conversion Rate by Variant", x = "Variant", y = "Conversion Rate") +
  scale_y_continuous(labels = scales::percent_format()) +
  theme_minimal()
```

<img width="1913" height="1008" alt="image" src="https://github.com/user-attachments/assets/b3b6a712-6a5b-4e01-a599-007a1f6d07f5" />

---

### Engagement Score Distribution

> A density plot reveals a heavy right-skew — most users have low interaction scores, but a "long tail" of highly engaged power users exists across both variants.

```r
ggplot(sessions, aes(x = engagement_score, fill = variant)) +
  geom_density(alpha = 0.4) +
  labs(title = "Engagement Score Distribution by Variant",
       x = "Engagement Score", y = "Density") +
  theme_minimal()
```

<img width="1909" height="1011" alt="image" src="https://github.com/user-attachments/assets/b26a6c32-176e-41d2-9712-2e1f6af984d2" />

---

### Persona-Level Conversion Analysis

> Segmenting by persona reveals which user types respond most strongly to the Smart Panel.

```r
persona_conv <- sessions %>%
  group_by(persona, variant) %>%
  summarise(conv_rate = mean(conversion))

ggplot(persona_conv, aes(x = persona, y = conv_rate, fill = variant)) +
  geom_col(position = "dodge") +
  labs(title = "Persona-wise Conversion Rate by Variant", y = "Conversion Rate") +
  scale_y_continuous(labels = scales::percent_format()) +
  theme_minimal()
```

<img width="1907" height="1012" alt="image" src="https://github.com/user-attachments/assets/bab6b463-9fad-48f7-be59-4d021c326dce" />

---

### Funnel Stage Analysis

> `tidyr::pivot_longer` reshapes wide-format funnel data for grouped bar plotting across all stages.

```r
funnel_plot <- sessions %>%
  group_by(variant) %>%
  summarise(visit = n(), engage = sum(engaged),
            cart = sum(add_to_cart), conversion = sum(conversion)) %>%
  tidyr::pivot_longer(cols = c(visit, engage, cart, conversion),
                      names_to = "stage", values_to = "count")

ggplot(funnel_plot, aes(x = stage, y = count, fill = variant)) +
  geom_col(position = "dodge") +
  labs(title = "Funnel Stages by Variant", y = "Number of Users") +
  theme_minimal()
```

<img width="1910" height="1008" alt="image" src="https://github.com/user-attachments/assets/74bcfa4a-e3ba-464c-9322-020e71d5ddb2" />

---

### Final A/B Uplift Visualization

> Dynamic text labels show the exact conversion percentage for each variant — the clearest single view of the experiment result.

```r
uplift_df <- data.frame(variant = c("A", "B"), conv_rate = c(pA, pB))

ggplot(uplift_df, aes(x = variant, y = conv_rate, fill = variant)) +
  geom_col() +
  geom_text(aes(label = paste0(round(conv_rate*100, 3), "%")), vjust = -0.5) +
  labs(title = "A/B Conversion Rate Comparison", y = "Conversion Rate") +
  scale_y_continuous(labels = scales::percent_format()) +
  theme_minimal()
```

<img width="1908" height="1009" alt="image" src="https://github.com/user-attachments/assets/04b0c01b-320d-46d0-8928-886cc452085f" />

---

## 🗃️ SQL Analytics Layer

These queries mirror the A/B testing, funnel modeling, and segmentation logic built in R and Power BI.

### Schema

```sql
CREATE TABLE users (
    user_id    INT PRIMARY KEY,
    persona    VARCHAR(50),
    signup_date DATE
);

CREATE TABLE sessions (
    session_id            INT PRIMARY KEY,
    user_id               INT,
    variant               CHAR(1),
    session_duration      INT,
    pages_visited         INT,
    interacted_with_panel INT,
    engaged               INT,
    added_to_cart         INT,
    converted             INT,
    engagement_score      FLOAT,
    time_to_conversion    FLOAT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```

### Join Users & Sessions
```sql
SELECT s.session_id, s.user_id, u.persona, u.signup_date,
       s.variant, s.session_duration, s.pages_visited,
       s.engagement_score, s.converted
FROM sessions s
JOIN users u ON s.user_id = u.user_id;
```

### Funnel Stage Counts
```sql
SELECT
    COUNT(*)                                        AS visits,
    SUM(CASE WHEN engaged = 1 THEN 1 END)          AS engaged,
    SUM(CASE WHEN added_to_cart = 1 THEN 1 END)    AS added_to_cart,
    SUM(CASE WHEN converted = 1 THEN 1 END)        AS conversions
FROM sessions;
```

### Variant-Level Funnel Metrics
```sql
SELECT variant,
    COUNT(*)                                        AS visits,
    SUM(CASE WHEN engaged = 1 THEN 1 END)          AS engaged,
    SUM(CASE WHEN added_to_cart = 1 THEN 1 END)    AS added_to_cart,
    SUM(CASE WHEN converted = 1 THEN 1 END)        AS conversions
FROM sessions
GROUP BY variant;
```

### Conversion Rate by Variant
```sql
SELECT variant, ROUND(AVG(converted), 4) AS conversion_rate
FROM sessions
GROUP BY variant;
```

### Persona-Level Drop-Off Analysis
```sql
SELECT persona,
    ROUND(SUM(CASE WHEN engaged = 1 THEN 1 END) * 1.0 / COUNT(*), 3)             AS visit_to_engage,
    ROUND(SUM(CASE WHEN added_to_cart = 1 THEN 1 END) * 1.0 / SUM(engaged), 3)   AS engage_to_cart,
    ROUND(SUM(CASE WHEN converted = 1 THEN 1 END) * 1.0 / SUM(added_to_cart), 3) AS cart_to_conversion
FROM sessions
JOIN users USING (user_id)
GROUP BY persona;
```

### High-Intent Power Users
```sql
SELECT user_id, persona,
    COUNT(*)               AS total_sessions,
    AVG(session_duration)  AS avg_duration,
    SUM(converted)         AS conversions
FROM sessions
JOIN users USING (user_id)
GROUP BY user_id, persona
HAVING SUM(converted) > 0;
```

### Time-to-Conversion Insights
```sql
SELECT variant,
    AVG(time_to_conversion) AS avg_time_to_convert,
    MIN(time_to_conversion) AS fastest_conversion,
    MAX(time_to_conversion) AS slowest_conversion
FROM sessions
WHERE converted = 1
GROUP BY variant;
```

### Panel Interaction → Conversion Lift
```sql
SELECT interacted_with_panel,
    ROUND(AVG(converted), 4) AS conversion_rate
FROM sessions
GROUP BY interacted_with_panel;
```

---

## 🗂️ Repository Structure

```
📦 user-behavior-ab-testing
│
├── 📁 data/
│   ├── users.csv
│   ├── sessions.csv
│   ├── sessions_clean.csv
│   └── sessions_features.csv
│
├── 📁 r-code/
│   ├── data_simulation.R
│   └── funnel_feature_engineering.R
│
├── 📁 screenshots/
│   ├── page1_dashboard.png
│   ├── page2_dashboard.png
│   └── insights.png
│
├── 📁 PowerBI/
│   └── A_B_Test_Dashboard.pbix
│
└── README.md
```

---

## 📊 Power BI Dashboard Features

```
  ✔  Variant A vs B conversion efficiency
  ✔  Funnel drop-off analysis
  ✔  Persona funnel segmentation
  ✔  Stage-wise conversion efficiency (A vs B)
  ✔  Interaction impact on conversion
  ✔  Dynamic slicers — Variant · Persona · Session Duration
```

---

## 🔍 Key Insights

```
  ┌─────────────────────────────────────────────────────────────────┐
  │                     WHAT THE DATA SHOWS                          │
  ├─────────────────────────────────────────────────────────────────┤
  │                                                                  │
  │  📈  Variant B consistently outperforms Variant A               │
  │      across all funnel stages                                    │
  │                                                                  │
  │  🎯  Largest bottleneck: Engage → Cart                          │
  │      The highest-leverage optimization area                      │
  │                                                                  │
  │  ⚡  High Intent & Deal Hunters show the highest               │
  │      funnel efficiency of all four personas                      │
  │                                                                  │
  │  🖱️  Panel interaction strongly increases                       │
  │      conversion likelihood                                       │
  │                                                                  │
  └─────────────────────────────────────────────────────────────────┘
```

---

## 🚀 Installation & Run

### 1 — Clone the repo
```bash
git clone https://github.com/<your-username>/<repo-name>.git
```

### 2 — Run R scripts in RStudio
```bash
r-code/data_simulation.R
r-code/funnel_feature_engineering.R
```

### 3 — Open the live Power BI dashboard
🔗 [View Dashboard →](https://app.powerbi.com/view?r=eyJrIjoiNDBjMTYyYmMtMWI2YS00MTUyLWJiMWQtNzM3YmMxOGNmMWMyIiwidCI6ImUxNGU3M2ViLTUyNTEtNDM4OC04ZDY3LThmOWYyZTJkNWE0NiIsImMiOjEwfQ%3D%3D)

---

## 🛠️ Tech Stack

| Area | Tool |
|---|---|
| Data Simulation & Engineering | R · tidyverse · tibble |
| Visualization (R) | ggplot2 · scales · tidyr |
| Database & Analytics | SQL (PostgreSQL concepts) |
| Dashboard | Power BI |
| Experiment Framework | A/B Testing — Variant A vs B |

---

<div align="center">

**Built with R · SQL · Power BI**

🔗 [**Open Live Dashboard →**](https://app.powerbi.com/view?r=eyJrIjoiNDBjMTYyYmMtMWI2YS00MTUyLWJiMWQtNzM3YmMxOGNmMWMyIiwidCI6ImUxNGU3M2ViLTUyNTEtNDM4OC04ZDY3LThmOWYyZTJkNWE0NiIsImMiOjEwfQ%3D%3D)

⭐ Star this repo if you found it useful!

</div>
