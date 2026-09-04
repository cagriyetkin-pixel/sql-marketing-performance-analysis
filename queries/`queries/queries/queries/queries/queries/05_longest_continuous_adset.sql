-- File: queries/05_longest_continuous_adset.sql
WITH unified_adsets AS (
    SELECT DISTINCT fabd.ad_date, fa.adset_name
    FROM public.facebook_ads_basic_daily fabd
    LEFT JOIN public.facebook_adset fa ON fabd.adset_id = fa.adset_id
    WHERE fabd.impressions > 0 AND fa.adset_name IS NOT NULL
    
    UNION
    
    SELECT DISTINCT ad_date, adset_name
    FROM public.google_ads_basic_daily
    WHERE impressions > 0 AND adset_name IS NOT NULL
),
ranked_dates AS (
    SELECT 
        adset_name,
        ad_date,
        ad_date - (DENSE_RANK() OVER (PARTITION BY adset_name ORDER BY ad_date) * INTERVAL '1 day') AS streak_group
    FROM unified_adsets
),
streak_lengths AS (
    SELECT 
        adset_name,
        MIN(ad_date) AS streak_start,
        MAX(ad_date) AS streak_end,
        COUNT(*) AS continuous_days
    FROM ranked_dates
    GROUP BY adset_name, streak_group
)
SELECT adset_name, streak_start, streak_end, continuous_days
FROM streak_lengths
ORDER BY continuous_days DESC
LIMIT 1;
