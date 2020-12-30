-- SOLUTION 1

-- CASE 1 : When x1 = y2, x2 = y1, x1 = y1 and there are atleast two pairs satisfying this condition. In this case, we don't want to eliminate the other pair. Therefore, it is necessary to include a consition which would take care of this. In layman terms, we can explain that select (x,y) when x1 = y1 and all the pairs where X = f1.x and Y = f1.y occuring more than once.  
select f1.x, f1.y from Functions f1 where f1.x = f1.y and (select * from Functions where X = f1.x and Y = f1.y)>1;
select f1.x, f1.y from Functions f1 where f1.x = f1.y order by f1.x, f1.y; -- This code fetches all the (x,y) pairs where x = y. There are 98 results for this query.
-- WE need to just find a pair that existed more than once. Count(*) comes into picture as it gives total number of rows in a result set including duplicate, null values. Therefore, following code:
select * from Functions where X = f1.x and Y = f1.y> 1;
-- Alternatively, above code can be shortened by:
select f1.X, f1.Y from Functions f1 where f1.X = f1.Y group by f1.X, f1.Y having count(*) >1;

-- CASE 2: When x1 = y2, x2 = y1, x1 != y1. This can give two results [(20,21) and (21,20)] but we don't want both results in our output. We just want (20,21). Hence, one more condition comes into picture. That is x1 < x2. We can consider two self joins of Functions table [f1 and f2]
SELECT f1.X, f1.Y FROM Functions AS f1, Functions AS f2
WHERE f1.X <> f1.Y AND f1.X = f2.Y AND f1.Y = f2.X and f1.X < f2.X;

-- FINAL SOLUTION
(select f1.X, f1.Y from Functions f1 where f1.X = f1.Y group by f1.X, f1.Y having count(*) >1) union (SELECT f1.X, f1.Y FROM Functions AS f1, Functions AS f2
WHERE f1.X <> f1.Y AND f1.X = f2.Y AND f1.Y = f2.X and f1.X < f2.X) order by X; -- Union ensure to remove duplicate values

-------------------------------------------------------------------------------------------------------------------------------------------------

-- SOLUTION 2

(SELECT f1.X, f1.Y FROM Functions AS f1 
WHERE f1.X = f1.Y GROUP BY f1.X, f1.Y HAVING COUNT(*) > 1)
UNION
(SELECT f1.X, f1.Y FROM Functions AS f1
WHERE EXISTS(SELECT X, Y FROM Functions WHERE f1.X = Y AND f1.Y = X AND f1.X < X))
ORDER BY X;
