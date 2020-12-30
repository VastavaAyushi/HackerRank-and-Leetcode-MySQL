-- My Solution

SELECT 
    p.product_name AS PRODUCT_NAME, SUM(o.unit) AS UNIT
FROM
    products p
        JOIN
    orders o ON p.product_id = o.product_id
WHERE
    YEAR(o.order_date) = 2020
        AND MONTH(o.order_date) = 02
GROUP BY p.product_id
HAVING SUM(o.unit) >= 100;

-- Best Runtime code

SELECT 
    p.product_name, SUM(o.unit) AS unit
FROM
    orders AS o
        LEFT JOIN
    products AS p ON o.product_id = p.product_id
WHERE
    o.order_date > '2020-01-31'
        AND o.order_date < '2020-03-01'
GROUP BY p.product_id
HAVING SUM(o.unit) >= 100;