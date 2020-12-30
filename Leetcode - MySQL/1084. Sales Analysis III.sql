-- SOLUTION 1

with a as (select product_id from sales where sale_date between "2019-01-01" and "2019-03-31"),
b as (select product_id from sales where sale_date < "2019-01-01" or sale_date > "2019-03-31")

select a.product_id, p.product_name from a join product p on p.product_id = a.product_id where a.product_id not in (select b.product_id from b) group by a.product_id;

-------------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

SELECT DISTINCT
    t1.product_id, t2.product_name
FROM
    Sales t1
        JOIN
    Product t2 ON t1.product_id = t2.product_id
WHERE
    t1.sale_date BETWEEN '2019-01-01' AND '2019-03-31'
        AND t1.product_id NOT IN (SELECT DISTINCT
            t1.product_id
        FROM
            Sales t1
                JOIN
            Product t2 ON t1.product_id = t2.product_id
        WHERE
            t1.sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31');
            
----------------------------------------------------------------------------------------------------

-- SIMPLER SOLUTION

-- In this question, we strictly want prouct_id/ids between '2019-01-01' AND '2019-03-31'. It is possible for product_ids to be sold in interval which doesn't fall between the dates specified. Following query is a very good way to handle it. By using MIN() and MAX() function along with the condition, it is certain that, even though there are multiple records of sale_date for a particular product_id, only the min and max date that lies between the specified condition wil be fetched!

-- For example: In our test case, product_id = 2 was sold in Spring 2019 but also in Summer 2019. By using MIN(sale_date), we get Spring 2019 date and by using MAX(sale_date), we get Summer 2019 date. So we can say that product_id = 2 doesn't satisy the ONLY condition of item to be strictly sold in Soring 2019. Now, to eliminate the Summer 2019 date, we will use the condition, MAX(sale_date) must be less than or equal to "2019-03-31". As it doesn't satisfy the condition, that record (product_id = 2) will not be included in the result set!!

with t as (
    select product_id
    from sales 
    group by 1
    having min(sale_date) >= '2019-01-01' 
    and max(sale_date) <= '2019-03-31'
)
select a.product_id, b.product_name 
from t a
join product  b
on a.product_id = b.product_id;