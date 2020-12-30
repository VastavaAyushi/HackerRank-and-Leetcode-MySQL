-- SOLUTION

SELECT 
    date_id,
    make_name,
    COUNT(DISTINCT lead_id) AS unique_leads,
    COUNT(DISTINCT partner_id) AS unique_partners
FROM
    dailysales
GROUP BY date_id , make_name;

----------------------------------------------------------------------------------------

-- OPTIMIZED CODE

SELECT 
    date_id,
    make_name,
    COUNT(DISTINCT lead_id) AS unique_leads,
    COUNT(DISTINCT partner_id) AS unique_partners
FROM
    DailySales
GROUP BY 1 , 2;