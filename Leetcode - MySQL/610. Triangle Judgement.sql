-- SOLUTION 1

SELECT 
    x,
    y,
    z,
    IF(x + y > z AND x + z > y AND y + z > x,
        'Yes',
        'No') AS triangle
FROM
    triangle
GROUP BY x , y , z;

-------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

SELECT 
    *,
    (CASE
        WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes'
        ELSE 'No'
    END) AS triangle
FROM
    triangle;