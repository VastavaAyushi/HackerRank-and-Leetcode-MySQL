-- SOLUTION 1

set @number= 21; -- intializing the variable to 21 because we are gonna decrement it
select repeat("* ", @number:= @number - 1) from information_schema.tables limit 20; -- repeat function repeats printing *  for 20 times (limit specified) operating on @number:= @number -1

------------------------------------------------------------------------------------------------------------------------------------

-- SOLUTION 2

-- giving alias to derived table is mandatory. In this vase, it is "t"
select repeat("* ", @number:= @number - 1) from information_schema.tables, (select @number:=21) t limit 20; 
