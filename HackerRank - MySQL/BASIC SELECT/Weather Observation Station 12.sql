-- SOLUTION 1

SELECT DISTINCT
    CITY
FROM
    STATION
WHERE
    NOT CITY RLIKE '^[AEIOUaeiou]'
        AND NOT CITY RLIKE '.*[AEIOUaeiou]$';