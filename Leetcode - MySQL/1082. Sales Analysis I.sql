-- SOLUTION 1

with a as (SELECT 
    s.seller_id AS seller_id, SUM(s.price) AS total_sales
FROM
    sales s
        JOIN
    product p USING (product_id)
GROUP BY seller_id)

SELECT 
    seller_id
FROM
    a
WHERE
    total_sales = (SELECT 
            MAX(total_sales)
        FROM
            A);
            
-----------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

-- Rank() over window function sorts the seller_id on the basis of sum(price). For example: Consider the output of sub-query of this question: {"headers": ["seller_id", "r"], "values": [[1, 1], [3, 1], [2, 3]]}. As we can see,seller_id =(1,3) have rank 1 because they have the highest sales and also same value [2800]. Rank() skips as many ranks as the numbers with same values. In this case, 2 seller_id have same value, hence, it skips 2 and assigns the (skipped values+1) number to the next different value. The RANK() function is useful for top-N and bottom-N reports.
  
SELECT seller_id
FROM
    (SELECT seller_id, RANK () OVER (ORDER BY SUM(price) DESC ) as r 
    FROM Sales s 
    GROUP BY seller_id) as t
WHERE r = 1;