-- SOLUTION 1
-- select p.product_id, round((sum(p.price*us.units)/sum(us.units)) over (partition by p.product_id),2) as average_price from prices p join unitssold us on p.product_id = us.product_id and us.purchase_date between p.start_date and p.end_date group by p.product_id;

SELECT 
    p.product_id, 
    ROUND(SUM(p.price * u.units)/SUM(u.units),2) as average_price
FROM 
    Prices p join UnitsSold u
on
    u.purchase_date between p.start_date and p.end_date -- This condition is very important because there is a difference price for same product_id between different time duration. For example: "product_id 1" has per unit price as $5 between 17th Feb and 28th Feb but $20 between 1st March and 22nd March. Therefore, for every product_id 1's purchase date between 17th and 28th Feb, it will be charged $5 per unit and hence this condition is mandatory to get appropriate results.
    AND p.product_id = u.product_id
GROUP BY
    p.product_id;
    
SELECT
    C.product_id AS product_id,
    ROUND(SUM(C.total_price) / SUM(C.units), 2) AS average_price
FROM 
    (
        SELECT 
            A.product_id AS product_id,
            (B.price * A.units) AS total_price,
            A.units AS units
        
        FROM UnitsSold AS A
        INNER JOIN Prices AS B
        ON A.product_id = B.product_id AND (A.purchase_date BETWEEN B.start_date AND B.end_date) 
    ) C
GROUP BY product_id;