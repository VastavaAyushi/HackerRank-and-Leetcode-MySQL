-- SOLUTION 1

/*
Tables are joint wrt code. For example: All "Code 1" will be populated by "age 40" only(refer table wands_property). As mentioned in the question, code 1 age 40 != code 2 age 40 since the relation is one to one. This gives us a table with id, age, coins and power of each code. Each code number will have same aged wands but with different powers. Our task is to fetch min price for each power in each code or age. Therefore, we will make a condition considering what if same age has different coins needed for same power. 

Min Coins Calculation: This is where you find out min. coins needed provided that the power and age are same. As you need non-evil wands, you use both conditions non-evil wands and minimum coins needed using an AND.
If you don't use this condition, you will end up getting all the rows with same age, power combination.
Table replication is needed in order for the min. coins condition to work.

Usage of JOINS:
JOINS were used in sub-query and the outer query as we need age from a different table.
Finally, you sort the outer query using power first and age next.
*/

SELECT 
    w.id, wp.age, w.coins_needed, w.power
FROM
    wands w
        JOIN
    wands_property wp ON w.code = wp.code
WHERE
    wp.is_evil != 1
GROUP BY wp.age
HAVING MIN(coins_needed) AND MAX(power)
ORDER BY w.power DESC , wp.age DESC;

-------------------------------------------------------------------------------------------------------------------------

-- SOLUTION 2

SELECT 
    a.id, b.age, a.coins_needed, a.power
FROM
    Wands a
        INNER JOIN
    Wands_Property b ON a.code = b.code
WHERE
    b.is_evil != 1
        AND a.coins_needed = (SELECT 
            MIN(Wands.coins_needed)
        FROM
            Wands
                INNER JOIN
            Wands_Property ON Wands.code = Wands_Property.code
        WHERE
            Wands_Property.age = b.age
                AND Wands.power = a.power)
ORDER BY a.power DESC , b.age DESC;

-----------------------------------------------------------------------------------------------------------------------

-- SOLUTION 3

SELECT 
    id, age, m.coins_needed, m.power
FROM
    (SELECT 
        code, power, MIN(coins_needed) AS coins_needed
    FROM
        Wands
    GROUP BY code , power) AS m
        JOIN
    Wands AS w ON m.code = w.code AND m.power = w.power
        AND m.coins_needed = w.coins_needed
        JOIN
    Wands_Property AS p ON m.code = p.code
WHERE
    p.is_evil = 0
ORDER BY m.power DESC , age DESC;