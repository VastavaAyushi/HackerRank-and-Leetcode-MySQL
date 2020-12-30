-- SOLUTION 1
select distinct p.product_id, sum(s.quantity) over (partition by p.product_id) as total_quantity from sales s join product p on s.product_id = p.product_id order by p.product_id;

--------------------------------------------------------------------------------------

-- SOLUTION 2

SELECT 
    p.product_id, SUM(quantity) AS total_quantity
FROM
    Product p
        JOIN
    Sales s ON p.product_id = s.product_id
GROUP BY p.product_id;