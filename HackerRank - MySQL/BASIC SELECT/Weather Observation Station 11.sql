-- SOLUTION 1

select distinct city from station where city rlike "^[^aeiou].*[^aeiou]$"; 
-- Difference between 10 and 11 is that in former it was optional to not have vowels either in start or at the end hence OR operation was used, whereas in latter, it was  mandatory condition to not have vowels at start as well as end of the mame, therefore,a pattern specifying ".*" concatenating both conditions was used. 
