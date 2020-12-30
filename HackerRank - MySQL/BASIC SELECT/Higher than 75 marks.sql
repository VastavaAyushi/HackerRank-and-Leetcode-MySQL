-- SOLUTION 1

select name from students where marks > 75 order by right(name,3), ID;
-- we can arrange the different conditions in order by clause as required. For example, question required to sort according to last three alphabets, if there exists two names with same last three alpha, then sort by their ID. So, the code order by right(name,3), ID. 
