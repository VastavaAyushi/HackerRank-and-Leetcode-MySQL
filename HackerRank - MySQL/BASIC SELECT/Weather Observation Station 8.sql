-- SOLUTION 1

select distinct city from station where city regexp "^[aeiou].*[aeiou]$";
-- starts with aeiou = ^[aeiou], since it can match one or more of these, hence .* (. is used because we want city succeeding with any alphabet other than [aeiou] after starting with [aeiou] and we want full name of these cities, therefore * is used) any city that starts with [aeiou] followed by any character (.) and can be multiple characters (*) and ending with [aeiou]

-- ends with vowels = [aeiou]$

------------------------------------------------------------------------------------------------------

-- SOLUTION 2

SELECT DISTINCT City
FROM Station
WHERE LEFT(City, 1) IN ('a', 'A', 'e', 'E', 'i', 'I', 'o', 'O', 'u', 'U') AND -- fetches leftmost or starting alphabets from city if in [aeiouAEIOU]
      RIGHT(City, 1) IN ('a', 'A', 'e', 'E', 'i', 'I', 'o', 'O', 'u', 'U'); -- fetches rightmost 1 character from city if in [aeiouAEIOU]
