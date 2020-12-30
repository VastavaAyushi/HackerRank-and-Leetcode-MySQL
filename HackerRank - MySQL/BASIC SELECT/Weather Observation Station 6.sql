-- SOLUTION 1

select distinct city from station where city regexp "^[aeiou]";
-- We can use regex in SQL by using above syntax. "^" stands for starts with alphabets mentioned in "[]". 
-- For more information: https://www.guru99.com/regular-expressions.html