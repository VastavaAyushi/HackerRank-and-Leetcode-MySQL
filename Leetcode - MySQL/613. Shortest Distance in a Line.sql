-- SOLUTION 1
SELECT MIN(a.x - b.x) AS shortest
FROM point a, point b
WHERE a.x > b.x;

--------------------------------------------------------------------------------------------------------------------

-- SOLUTION 2
SELECT 
    MIN(ABS(p1.x - p2.x)) AS shortest
FROM
    point p1,
    point p2
WHERE
    p1.x <> p2.x
ORDER BY p1.x , p2.x;

/*STEP BY STEP:

1. APPLY CROSS JOIN + SELF JOIN BY FOLLOWING QUERY:
SELECT P1.X, P2.X FROM POINT P1, POINT P2 ORDER BY P1.X, P2.X;
OUTPUT: 9 LISTS : {"headers": ["X", "X"], "values": [[-1, -1], [-1, 0], [-1, 2], [0, -1], [0, 0], [0, 2], [2, -1], [2, 0], [2, 2]]}

2. AS WE CAN SEE THERE ARE VALUES WHEREIN P1.X AND P2.X ARE EQUAL ([0, 0], [2, 2], [-1, -1]). WE NEED TO ELIMINATE THESE VALUES AS WE ARE INTERESTED IN SHORTEST DISTANCE BETWEEN TWO POINTS AND NOT DIFFERENCE BETWEEN POINT ITSELF! THIS INTRODUCES FOLLLOWING CONDITION IN WHERE CLAUSE:
WHERE P1.X <> P2.X

3. FINALLY, WE NEED TO FETCH THE MINIMUM ABSOLUTE VALUE OF DIFFERENCE BETWEEN TWO POINTS, WHICH CAN BE OBTAINED USING:
MIN(ABS(P1.X - P2.X))

4. FINAL CODE:
SELECT 
    MIN(ABS(p1.x - p2.x)) AS shortest
FROM
    point p1,
    point p2
WHERE
    p1.x <> p2.x
ORDER BY p1.x , p2.x;
*/

