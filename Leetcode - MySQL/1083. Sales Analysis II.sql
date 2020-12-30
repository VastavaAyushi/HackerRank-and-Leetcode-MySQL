-- SOLUTION 1

with a as (select * from sales s join product p using (product_id))

select distinct buyer_id from a where buyer_id in (select distinct buyer_id from a where product_name = "S8") and buyer_id not in (select distinct buyer_id from temp where product_name = "iphone");

-----------------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

with t as (select buyer_id,product_name from Sales as s left join Product as p
on s.product_id=p.product_id)

select distinct buyer_id from t where product_name='S8' and
buyer_id not in (select buyer_id from t where product_name='Iphone');

-----------------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION 2

SELECT buyer_id
FROM Product JOIN Sales USING(product_id)
GROUP BY buyer_id
HAVING GROUP_CONCAT(product_name) LIKE '%S8%' -- Any product name with S8 in it
    AND GROUP_CONCAT(product_name) NOT LIKE '%iPhone%';
        
-----------------------------------------------------------------------------------------------------

-- SOLUTION 4 
    
SELECT buyer_id
FROM Product p
INNER JOIN Sales s
ON p.product_id = s.product_id
GROUP BY buyer_id
having sum(p.product_name = 'S8') > 0 and sum(p.product_name = 'iPhone') = 0;