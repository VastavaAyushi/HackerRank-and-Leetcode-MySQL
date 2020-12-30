-- SOLUTION 1

select distinct city from station where city rlike "^[^aeiou]" or city rlike "[^aeiou]$";

select distinct city from station where city rlike "^[^aeiou]|[^aeiou]$";