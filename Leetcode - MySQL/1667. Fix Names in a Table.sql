-- SOLUTION 1 and OPTIMIZED SOLUTION

SELECT 
    user_id,
    CONCAT(UPPER(LEFT(name, 1)), -- Capitalizing the first letter
            LOWER(SUBSTRING(name, 2, LENGTH(name)))) AS name -- Lowercasing rest of the letters
FROM
    users
ORDER BY user_id;