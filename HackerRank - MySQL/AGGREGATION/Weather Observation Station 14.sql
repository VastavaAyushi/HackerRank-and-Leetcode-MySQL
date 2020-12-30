-- SOLUTION 1

-- Question asked to round the answer, hence, there is no need to use round() in inner query. I was using where "lat_n in" instead of where lat_n =; this will make a huge difference as in outputs a boolean value whereas = fetches the exact value.

SELECT 
    ROUND(long_w, 4)
FROM
    station
WHERE
    lat_n = (SELECT 
            MAX(lat_n)
        FROM
            station
        WHERE
            lat_n < 137.2345);

