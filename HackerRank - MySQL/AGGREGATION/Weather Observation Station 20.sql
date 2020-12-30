-- SOLUTION 1

-- Link to refer: https://nifannn.github.io/2017/10/23/SQL-Notes-Hackerrank-Weather-Observation-Station-20/
-- Steps in finding median of any table in SQL

-- Step 1: First sort the table in descending order. In order to calculate the median, we would require the indexes of each row in the table so that we can carry on with the calculation depending on the number of even or odd records.
set @rowindex:= -1; -- Initilaizing the index by -1 so that when incremented by 1, it will start the counting from zero

-- Step 2: Subquery sorting the records in ascending order. Output of this query will be a table of two columns; rowindex and latitude
select @rowindex := @rowindex+1 as rowindex, lat_n from station order by lat_n;

-- Step 3: After above results, we would like to calculate median. We know if there are odd number of records (say 9;indexed 0 to 8), median would be simply the middle value indexed [8/2=4]. If there are even records (say 10, indexed 0 to 9), median would be average of index(4,5)  -->(floor(9/2), ceil(9/2)) --> (4,5). This condition can be coded as:
 -- where rowindex in (floor(@rowindex/2), ceil(@rowindex/2))
 
-- Step 4: Finally, we gotta take the average of results fetched after where clause. Now if odd records (9 records say) --> rowindex(8/2,8/2) --> rowindex(4,4) --> average of record indexed at 4. 
-- If even records (say 10 records) --> rowindex(9/2,9/2) --> rowindex(4,5) --> average of records indexed at 4th and 5th position.
-- select round(avg(lat_n),4) from 

-- Final query would be as follows:
set @rowindex:= -1;
select round(avg(lat_n),4) from (select @rowindex := @rowindex+1 as rowindex, lat_n from station order by lat_n) where rowindex in (floor(@rowindex/2), ceil(@rowindex/2)); 
-- As we have to use rowindex in "where" clause which is used in subquery, we need to alias our subquery. Therefore, query changes as follows:

set @rowindex:= -1;
SELECT 
    ROUND(AVG(x.lat_n), 4)
FROM
    (SELECT 
        @rowindex:=@rowindex + 1 AS rowindex, lat_n
    FROM
        station
    ORDER BY lat_n) as x
WHERE
    x.rowindex IN (FLOOR(@rowindex / 2) , CEIL(@rowindex / 2)); 

---------------------------------------------------------------------------------------------------------------------------

-- SOLUTION 2

SELECT 
  @rowindex := COUNT(*) + 1
FROM STATION;
  
WITH i as (
  SELECT
    LAT_N,
    ROW_NUMBER() OVER (ORDER BY LAT_N) AS rowindex
  FROM
    STATION
)

SELECT
  ROUND(AVG(LAT_N),4) AS MEDIAN_CALCULATION
FROM
  i
WHERE
  i.rowindex IN (FLOOR(@rowindex / 2) , CEIL(@rowindex / 2));
