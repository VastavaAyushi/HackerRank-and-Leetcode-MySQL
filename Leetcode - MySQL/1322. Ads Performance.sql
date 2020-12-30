-- SOLUTION 1

SELECT 
    temp.ad_id,
    IFNULL(ROUND(100 * (temp.clicked / (temp.clicked + temp.viewed)),
                    2),
            0) AS ctr
FROM
    (SELECT 
        ad_id,
            SUM(CASE
                WHEN ads.action = 'viewed' THEN 1
                ELSE 0
            END) AS viewed,
            SUM(CASE
                WHEN ads.action = 'clicked' THEN 1
                ELSE 0
            END) AS clicked,
            SUM(CASE
                WHEN ads.action = 'ignored' THEN 1
                ELSE 0
            END) AS ignored
    FROM
        ads
    GROUP BY ad_id) AS temp
ORDER BY ctr DESC , temp.ad_id;

-------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

with CTE1 as (
select ad_id,
sum(case when action = "Clicked" then "1" else "0" end) as totalclicked,
sum(case when action = "Viewed" then "1" else "0" end) as totalviewed
from ads
group by ad_id
)


select ad_id, 
case when totalclicked != 0 then 
round(100 * (totalclicked/(totalclicked+totalviewed)),2)
else 0.00 end as ctr
from CTE1
order by ctr desc,ad_id;

--------------------------------------------------------------------------------------------

-- SIMPLER SOLUTION

SELECT 
    ad_id,
    IFNULL(ROUND(SUM(CASE
                        WHEN action = 'Clicked' THEN 1
                        ELSE 0
                    END) * 100 / (SUM(CASE
                        WHEN action = 'Clicked' OR action = 'Viewed' THEN 1
                        ELSE 0
                    END)),
                    2),
            0) AS ctr
FROM
    Ads
GROUP BY ad_id
ORDER BY ctr DESC , ad_id;


