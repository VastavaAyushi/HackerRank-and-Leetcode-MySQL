-- My Solution
WITH A AS (SELECT 
    o.customer_id,
    c.name,
    SUM(o.quantity * p.price) AS total_price_JuneandJuly
FROM
    customers c
        JOIN
    orders o using(customer_id)
        JOIN
    product p using(product_id)
WHERE
    EXTRACT(MONTH FROM o.order_date) = 6
GROUP BY o.customer_id , c.name
HAVING SUM(o.quantity * p.price) >= 100),

B AS (SELECT 
    o.customer_id,
    c.name,
    SUM(o.quantity * p.price) AS total_price_July
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    product p ON p.product_id = o.product_id
WHERE
    EXTRACT(MONTH FROM o.order_date) = 7
GROUP BY o.customer_id , c.name
HAVING SUM(o.quantity * p.price) >= 100)

SELECT 
    A.customer_id, A.name
FROM
    A
        JOIN
    B ON A.customer_id = B.customer_id
ORDER BY A.customer_id;

----------------------------------------------------------------------------------------------------------------

-- Optimal Solution 1
with tots as (
SELECT 
    o.customer_id,
    DATE_FORMAT(o.order_date, '%Y-%m'),
    SUM(p.price * o.quantity) tot
FROM
    orders o
        JOIN
    product p USING (product_id)
WHERE
    MONTH(o.order_date) = 7
        OR MONTH(o.order_date) = 6
GROUP BY 1 , 2
HAVING SUM(p.price * o.quantity) >= 100
), selcust as (
SELECT 
    customer_id
FROM
    tots
GROUP BY customer_id
HAVING COUNT(*) = 2
)
SELECT 
    customer_id, name
FROM
    selcust
        JOIN
    customers USING (customer_id);
