-- SOLUTION 1

SELECT 
    extra AS report_reason,
    COUNT(DISTINCT post_id) AS report_count -- We are just concerned about "reports" flagged for unique posts. If in a day, post with same id was reported thrice, that'll be counted as 1
FROM
    actions
WHERE
    action_date = '2019-07-04'
        AND action = 'report'
GROUP BY extra;

--------------------------------------------------------------------------------------------------------------

-- OPTIMIZED CODE

SELECT 
    extra AS report_reason,
    COUNT(DISTINCT post_id) AS report_count
FROM
    Actions
WHERE
    action_date = DATE('2019-07-04')
        AND action = 'report'
GROUP BY extra;