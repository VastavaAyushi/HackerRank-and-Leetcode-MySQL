----------------------------------------------------------------------------
#SOLUTION 1

SELECT 
    v.customer_id, COUNT(v.customer_id) AS count_no_trans
FROM
    visits v
        LEFT JOIN
    transactions t ON v.visit_id = t.visit_id
WHERE
    t.transaction_id IS NULL
GROUP BY v.customer_id;
-----------------------------------------------------------------------------
#SOLUTION 2 using CTE (95% better than other solutions)

WITH A AS (SELECT 
    v.customer_id AS cust_id, t.transaction_id AS trans
FROM
    visits v
        LEFT JOIN
    transactions t ON v.visit_id = t.visit_id
WHERE
    t.transaction_id IS NULL)


SELECT 
    cust_id AS customer_id, COUNT(cust_id) AS count_no_trans
FROM
    A
GROUP BY cust_id;
---------------------------------------------------------------------------------------
#BEST SOLUTION

SELECT 
    v.customer_id, COUNT(*) AS count_no_trans
FROM
    visits v
WHERE
    v.visit_id NOT IN (SELECT 
            visit_id
        FROM
            transactions)
GROUP BY v.customer_id;