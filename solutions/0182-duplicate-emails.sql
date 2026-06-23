# Write your MySQL query statement below
#Select p1.email as Email FROM Person p1
#Inner Join Person p2 ON p1.email = p2.email
#Where p1.id <> p2.id
#Group by Email


#Select email as Email From Person Group by email having count(email) > 1;


select email as Email from Person group by 1 having count(1) > 1