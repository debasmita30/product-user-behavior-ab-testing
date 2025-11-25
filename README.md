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

Screenshots:-



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
