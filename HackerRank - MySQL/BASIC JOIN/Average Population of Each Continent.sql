-- SOLUTION 1

SELECT 
    co.continent, FLOOR(AVG(ct.population))
FROM
    city ct
        JOIN
    country co ON ct.countrycode = co.code
GROUP BY co.continent; 
