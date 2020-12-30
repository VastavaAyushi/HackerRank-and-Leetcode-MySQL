-- MY SOLUTION

WITH A AS (SELECT 
    CUSTOMER_NUMBER, COUNT(CUSTOMER_NUMBER) AS COUNT_CUSTOMER
FROM
    ORDERS
GROUP BY CUSTOMER_NUMBER)

SELECT 
    CUSTOMER_NUMBER
FROM
    A
WHERE
    COUNT_CUSTOMER = (SELECT 
            MAX(COUNT_CUSTOMER)
        FROM
            A);
            
-- OPTIMAL SOLUTION

SELECT 
    customer_number
FROM
    orders
GROUP BY customer_number
ORDER BY COUNT(*) DESC
LIMIT 1;

