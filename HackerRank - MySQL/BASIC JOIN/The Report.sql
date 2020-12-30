-- SOLUTION 1

SELECT 
    IF(g.grade < 8, 'Null', s.name), g.grade, s.marks
FROM
    students s
        JOIN
    grades g ON s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY g.grade DESC , s.name , s.marks ASC;
-- Mistakes: Since there was no connection link mentioned in question between tables, it was quite obvious to guess one. We were supposed to check marks if they fall under which grade category. 

-- FINAL SOLUTION

SELECT 
    IF(g.grade >= 8, s.name, NULL), g.grade, s.marks
FROM
    students s
        INNER JOIN
    grades g ON s.marks BETWEEN min_mark AND max_mark
ORDER BY g.grade DESC , s.name , s.marks ASC;

-- For more information: https://www.w3schools.com/sql/func_mysql_if.asp
