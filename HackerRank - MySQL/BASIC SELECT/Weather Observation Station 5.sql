-- SOLUTION 1

select city, max(length(city)) from station order by city asc limit 1;
-- Problem in this solution is that with aggregate function in select clause, it is required to use group by clause in the query. Not abiding by it throws error. Hence, current solution is:
select city,length(city) from station where length(city) = (select min(length(city)) from station) ORDER BY CITY LIMIT 1; -- First write a query to fetch city having minimum characters in the column city and assign it to length(city), this will turn into length(city) = 3, say, now fetch the name of this city by using select statement. order by city because we want alphabetical result limiting to 1 output, if multiple output exists.
select city,length(city) from station where length(city) = (select max(length(city)) from station) ORDER BY CITY LIMIT 1; -- The Columns which are not present in the Aggregate function should come on group by clause but if all the columns in select have aggregate functions, then we don't require group by for that query. 
