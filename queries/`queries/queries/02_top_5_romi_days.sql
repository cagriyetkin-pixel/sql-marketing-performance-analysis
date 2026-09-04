-- File: queries/02_top_5_romi_days.sql
WITH unified_ads AS (
    SELECT ad_date, spend, value FROM public.facebook_ads_basic_daily
    UNION ALL
    SELECT ad_date, spend, value FROM public.google_ads_basic_daily
)
SELECT 
    ad_date,
    SUM(spend) AS total_spend,
    SUM(value) AS total_value,
    ROUND(
        ((SUM(value) - SUM(spend)) / NULLIF(SUM(spend), 0)) * 100::numeric, 
        2
    ) AS total_romi
FROM unified_ads
GROUP BY ad_date
ORDER BY total_romi DESC
LIMIT 5;
