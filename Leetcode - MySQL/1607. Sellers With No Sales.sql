-- SOLUTION 1

with a as (select s.seller_name, o.seller_id, count(o.sale_date) as order_count from orders o join seller s on o.seller_id = s.seller_id where extract(year from sale_date) = "2020" group by seller_id)

select seller_name from seller where seller_name not in (select a.seller_name from a) order by seller_name asc;

---------------------------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

SELECT 
    s1.seller_name
FROM
    Seller s1
WHERE
    s1.seller_id NOT IN (SELECT 
            s.seller_id
        FROM
            Orders o
                LEFT JOIN
            Seller s ON o.seller_id = s.seller_id
        WHERE
            YEAR(o.sale_date) = '2020')
ORDER BY 1;