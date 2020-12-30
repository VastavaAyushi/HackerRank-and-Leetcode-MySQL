-- SOLUTION 1

SELECT 
    c.country_name,
    CASE
        WHEN AVG(weather_state) <= 15 THEN 'Cold'
        WHEN AVG(weather_state) >= 25 THEN 'Hot'
        ELSE 'Warm'
    END AS weather_type
FROM
    weather w
        JOIN
    countries c USING (country_id)
WHERE
    EXTRACT(MONTH FROM day) = 11
GROUP BY country_name;

-- OPTIMIZED CODE

SELECT 
    country_name,
    CASE
        WHEN AVG(weather_state) <= 15 THEN 'Cold'
        WHEN AVG(weather_state) >= 25 THEN 'Hot'
        ELSE 'Warm'
    END AS 'weather_type'
FROM
    countries AS c,
    weather AS w
WHERE
    c.country_id = w.country_id
        AND w.day BETWEEN '2019-11-01' AND '2019-11-30'
GROUP BY country_name;