-- SOLUTION 1

SELECT 
    CT.NAME
FROM
    CITY CT
        JOIN
    COUNTRY CRTY ON CT.COUNTRYCODE = CRTY.CODE
WHERE
    CRTY.CONTINENT = 'AFRICA';