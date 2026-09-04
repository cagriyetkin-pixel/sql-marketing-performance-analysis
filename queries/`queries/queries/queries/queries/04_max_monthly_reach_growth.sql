WITH unified_ads AS (
    SELECT fabd.ad_date, fc.campaign_name, fabd.reach
    FROM public.facebook_ads_basic_daily fabd
    LEFT JOIN public.facebook_campaign fc ON fabd.campaign_id = fc.campaign_id
    UNION ALL
    SELECT ad_date, campaign_name, reach FROM public.google_ads_basic_daily
),
monthly_reach AS (
    SELECT 
        DATE_TRUNC('month', ad_date)::date AS month_start,
        campaign_name,
        SUM(reach) AS total_reach
    FROM unified_ads
    WHERE campaign_name IS NOT NULL
    GROUP BY month_start, campaign_name
),
reach_diff AS (
    SELECT 
        month_start,
        campaign_name,
        total_reach,
        LAG(total_reach) OVER (PARTITION BY campaign_name ORDER BY month_start) AS prev_month_reach,
        total_reach - LAG(total_reach) OVER (PARTITION BY campaign_name ORDER BY month_start) AS reach_growth
    FROM monthly_reach
)
SELECT 
    month_start,
    campaign_name,
    prev_month_reach,
    total_reach,
    reach_growth
FROM reach_diff
WHERE reach_growth IS NOT NULL
ORDER BY reach_growth DESC
LIMIT 1;
