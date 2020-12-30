-- SOLUTION 1

SELECT 
    ROUND((A.immediate_order_date / B.total_delivery) * 100,
            2) AS immediate_percentage
FROM
    (SELECT 
        COUNT(order_date) AS immediate_order_date
    FROM
        delivery
    WHERE
        order_date = customer_pref_delivery_date) AS A,
    (SELECT 
        COUNT(delivery_id) AS total_delivery
    FROM
        delivery) AS B;
        
------------------------------------------------------------------------------------------------

-- SOLUTION 2
SELECT 
    ROUND(100 * AVG(order_date = customer_pref_delivery_date),
            2) AS immediate_percentage
FROM
    Delivery;
    
----------------------------------------------------------------------------------------------------

-- SOLUTION 3
SELECT 
    ROUND(100* AVG(CASE
                WHEN order_date = customer_pref_delivery_date THEN 1
                ELSE 0
            END),
            2) AS immediate_delivery
FROM
    delivery;

----------------------------------------------------------------------------------------------

-- SOLUTION 4
SELECT 
    ROUND((num.immediate_date * 100) / COUNT(*), 2) AS immediate_percentage
FROM
    Delivery,
    (SELECT 
        COUNT(*) AS immediate_date
    FROM
        DELIVERY
    WHERE
        order_date = customer_pref_delivery_date) AS num;