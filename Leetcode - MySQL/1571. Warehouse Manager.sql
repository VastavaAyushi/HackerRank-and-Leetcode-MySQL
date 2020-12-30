-- SOLUTION 1

-- In order to find the cubic feet of volume the inventory occupies in each warehouse, we need to first find the volumne of each inventory. This value can then be multiplied by number of units of each inventory in the warehouse to find what is asked!

-- We begin with creating a new column VOL in the product's table with the volume value of each product_id. As we'd further require this value to multiply with the number of units, we'll use CTE as follows:

WITH A AS (SELECT 
    PRODUCT_ID AS PROD_ID,
    PRODUCT_NAME AS PROD_NAME,
    (WIDTH * LENGTH * HEIGHT) AS VOL
FROM
    PRODUCTS P
ORDER BY PRODUCT_ID)

-- Now, to find the total volume corresponding to each warehouse_name, we know for sure that we've to group ourr query by the w.name. Secondly, we'll multiply the volume calculated above with all the product_id in the warehouse table for respective warehouse_name (LCHouse1,LCHouse2,LCHouse3).

SELECT 
    W.NAME AS WAREHOUSE_NAME, SUM(W.UNITS * A.VOL) AS VOLUME
FROM
    A
        RIGHT JOIN
    WAREHOUSE W ON A.PROD_ID = W.PRODUCT_ID
GROUP BY W.NAME;

-- FINAL QUERY

WITH A AS (SELECT PRODUCT_ID AS PROD_ID, PRODUCT_NAME AS PROD_NAME, (WIDTH*LENGTH*HEIGHT) AS VOL FROM PRODUCTS P ORDER BY PRODUCT_ID)

SELECT W.NAME AS WAREHOUSE_NAME, SUM(W.UNITS * A.VOL) AS VOLUME FROM A RIGHT JOIN WAREHOUSE W ON A.PROD_ID = W.PRODUCT_ID GROUP BY W.NAME;

-------------------------------------------------------------------------------------------

-- Optimized Query (Best Solution)

SELECT 
    name warehouse_name,
    SUM((width * length * height) * units) volume
FROM
    warehouse w,
    products p
WHERE
    w.product_id = p.product_id
GROUP BY name;