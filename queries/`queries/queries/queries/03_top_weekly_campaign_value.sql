WITH unified_ads AS (
    SELECT fabd.ad_date, fc.campaign_name, fabd.value
    FROM public.facebook_ads_basic_daily fabd
    LEFT JOIN public.facebook_campaign fc ON fabd.campaign_id = fc.campaign_id
    UNION ALL
    SELECT ad_date, campaign_name, value FROM public.google_ads_basic_daily
)
SELECT 
    DATE_TRUNC('week', ad_date)::date AS week_start,
    campaign_name,
    SUM(value) AS total_value
FROM unified_ads
WHERE campaign_name IS NOT NULL
GROUP BY week_start, campaign_name
ORDER BY total_value DESC
LIMIT 1;
