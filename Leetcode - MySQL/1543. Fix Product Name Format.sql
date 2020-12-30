-- SOLUTION 1

SELECT 
    TRIM(LOWER(product_name)) AS product_name,
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_date,
    COUNT(sale_date) AS total
FROM
    sales
GROUP BY EXTRACT(MONTH FROM sale_date) , TRIM(LOWER(product_name)) -- Group by doesn't take alias, therefore complete expression must be mentioned
ORDER BY product_name ASC , sale_date ASC;

---------------------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

SELECT 
    LOWER(TRIM(product_name)) AS product_name,
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_date,
    COUNT(*) AS total
FROM
    Sales
GROUP BY 1 , 2
ORDER BY 1 , 2;

