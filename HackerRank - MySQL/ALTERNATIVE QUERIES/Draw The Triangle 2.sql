-- SOLUTION 1

set @star = 0;
SELECT 
    REPEAT('* ', @star:=@star + 1)
FROM
    information_schema.tables
LIMIT 20; -- Jisse start karna ho, usse -1 pe initialize kardo variable ko.alter
