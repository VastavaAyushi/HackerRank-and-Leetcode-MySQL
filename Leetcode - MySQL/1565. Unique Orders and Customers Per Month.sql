-- SOLUTION 1

SELECT 
    CONCAT(EXTRACT(YEAR FROM order_date),
            '-',
            EXTRACT(MONTH FROM order_date)) AS month,
    COUNT(customer_id) AS order_count,
    COUNT(DISTINCT customer_id) AS customer_count
FROM
    orders
WHERE
    invoice > 20
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY month;

-----------------------------------------------------------------------------------

-- SOLUTION 2

SELECT 
    SUBSTRING(order_date, 1, 7) AS month, -- SUBSTRING MEANS INCLUDING 1 (START POINT) EXTRACT IN TOTAL 7 CHARACTERS, I.E., EXTRACT ADDITIONAL 6 FOLLOWING CHARACTERS
    COUNT(DISTINCT order_id) AS order_count,
    COUNT(DISTINCT customer_id) AS customer_count
FROM
    Orders
WHERE
    invoice > 20
GROUP BY SUBSTRING(order_date, 1, 7);

-- Substring takes 3 arguments in its function [string on which operation is to performed, starting index, number of characters to extract]
-- Note: For ease of understanding, consider an example, substring(order_date, 1,7). One sure thing is the final string will have 7 characters in total. Now, what'll be those characters? This'll be determined by the starting index and length of string specified. In our example, it'll start at 1st index till 7th index. If starting index is a positive number, this function extracts from the beginning of the string. If it is a negative number, this function extracts from the end of the string.

----------------------------------------------------

-- OPTIMIZED SOLUTION

SELECT 
    LEFT(order_date, 7) AS month, 
    COUNT(DISTINCT order_id) AS order_count,
    COUNT(DISTINCT customer_id) AS customer_count
FROM
    orders
WHERE
    invoice > 20
GROUP BY LEFT(order_date, 7);

-- Alternate way to extract month of the year from a date: DATE_FORMAT(order_date, "%Y-%m") as month