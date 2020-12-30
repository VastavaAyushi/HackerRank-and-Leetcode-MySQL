-- SOLUTION 1

SELECT 
    COUNT(Occupation = 'Doctor') AS Doctor_count,
    COUNT(Occupation = 'Singer') AS Singer_count,
    COUNT(Occupation = 'Actor') AS Actor_count,
    COUNT(Occupation = 'Professor') AS Professor_count
FROM
    occupations
ORDER BY count , names;

SELECT CONCAT(Name, '(', LEFT(Occupation, 1), ')') AS acronym from OCCUPATIONS order by Name;
    
select CONCAT('There are a total of ',
            COUNT(*)," ",
            LOWER(Occupation),
            's.')
FROM
    OCCUPATIONS GROUP BY Occupation
ORDER BY count(Occupation) asc, Occupation;
