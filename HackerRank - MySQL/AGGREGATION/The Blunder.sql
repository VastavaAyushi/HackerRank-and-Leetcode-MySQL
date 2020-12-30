-- SOLUTION 1

SELECT CEIL(AVG(SALARY) - AVG(REPLACE(cast(SALARY as char), '0', ''))) from employees;
-- replace actual salary figure's zeroes by blank space to get mistaken table. Using ceil or floor will round the output to nearest integer whereas using round will give wrong answer as it doesn't round the integer to nearest whole number/integer. Replace() can only be used with strings, hence, we need to convert the salary which is in integer to a string using cast function and then use replace.
