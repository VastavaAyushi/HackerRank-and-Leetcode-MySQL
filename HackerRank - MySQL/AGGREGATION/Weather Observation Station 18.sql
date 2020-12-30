-- SOLUTION 1

-- abs() is to find the absolute value of any output

SELECT 
    ROUND(ABS(MIN(lat_n) - MAX(lat_n)), 4) + ROUND(ABS(MIN(long_w) - MAX(long_w)), 4)
FROM
    station;

