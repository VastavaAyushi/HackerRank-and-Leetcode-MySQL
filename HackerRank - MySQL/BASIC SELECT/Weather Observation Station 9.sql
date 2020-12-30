-- SOLUTION 1

select distinct city from station where city regexp "^[^aeiou]"; -- double ^ negates the premise.