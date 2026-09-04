# SQL Marketing Performance & Campaign Analysis

An end-to-end SQL analysis project evaluating online advertising campaigns (Google Ads & Facebook Ads). This project focuses on aggregating cross-channel marketing data, calculating core performance metrics (ROMI, Reach Growth, Spend), and uncovering continuous delivery patterns.

---

### 📊 Business Questions & Analysis Scope

1. **Daily Spend Overview:** Calculating minimum, average, and maximum daily spend for Google and Facebook Ads.
2. **Top ROMI Days:** Identifying the top 5 days with the highest Return on Marketing Investment across both platforms.
3. **Top Performing Campaign:** Finding the campaign with the highest weekly total revenue/value.
4. **Monthly Reach Growth:** Analyzing month-over-month reach growth to isolate top-performing campaigns.
5. **Continuous Impression Streak:** Determining the `adset` with the longest uninterrupted streak of daily impressions using SQL window functions.

---

### 🛠️ Tech Stack & Database Structure

- **Database:** PostgreSQL (`ads_analysis_goit_course`)
- **SQL Client:** DBeaver
- **Techniques Used:** CTEs (`WITH` clauses), Window Functions (`LAG`, `DENSE_RANK`), `UNION ALL`, Data Aggregations, Date/Time Transformations (`DATE_TRUNC`, Interval math).

---

### 📁 Project Structure

```text
├── README.md
└── queries/
    ├── 01_daily_spend_metrics.sql
    ├── 02_top_5_romi_days.sql
    ├── 03_top_weekly_campaign_value.sql
    ├── 04_max_monthly_reach_growth.sql
    └── 05_longest_continuous_adset.sql
