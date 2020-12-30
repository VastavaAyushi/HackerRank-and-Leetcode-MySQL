-- SOLUTION 1

-- Prefix must start with letters, therefore, ^[a-zA-z]. There can be more than 1 characters in prefix, hence, a wildcard [+] for handlig one or more occurences is to be used. ^[a-zA-Z]+ means mail must begin with a letter, be it lowercase or uppercase, and the length can be anything from 1 to infinite. Alternatively, even if I don't use '+', it is very well handled by '^' at the beginning of the regex. It will make sure that mail starts with a letter only. 

-- Next step is to include other characters succeeding letter/letters. Now, it can be any combination of numbers [0-9], period[.], underscore [_] or dash[-]. These characters may or may not occur in the prefix, which means, I can use a wildcard which handles zero or more occurences, i.e., "*". Regexp [0-9._-]*

-- Lastly, domain name must be "@leetcode.com". As I know, domain name always comes last in any email-id, so I was certain which wildcard must be used here ["$"]. This one is pretty straightforward and can be handled using regexp '@leetcode.come$'

-- Combining all the steps, I used regexp '^[a-zA-Z][0-9._-]*@leetcode.come$' but my output was incorrect : {"headers": ["user_id", "name", "mail"], "values": [[1, "Winston", "winston@leetcode.com"], [3, "Annabelle", "bella-@leetcode.com"]]}

-- Why so? This is because, there are email ids which have letters along with numbers and special characters. Example: "sally.come@leetcode.com". After beginning with letters [sally], there is a combination of letters and a period succeeding it [.come]. In the above regex, I didn't include letters in my expression and therefore, this particular email-id wasn't included in the output. I resolved this by simply adding lettes in the special characters regex like [a-zA-Z0-9.-_]*

-- Final code is as follows:

SELECT 
    user_id, name
FROM
    users
WHERE
    mail REGEXP '^[a-zA-Z]+[a-zA-Z0-9-._]*@leetcode.com$';