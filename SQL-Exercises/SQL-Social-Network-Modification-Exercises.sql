/* **

-- Highschooler ( ID, name, grade )
-- English: There is a high school student with unique ID and a given first name in a certain grade.

-- Friend ( ID1, ID2 )
-- English: The student with ID1 is friends with the student with ID2. Friendship is mutual, so if (123, 456) is
-- in the Friend table, so is (456, 123).

-- Likes ( ID1, ID2 )
-- English: The student with ID1 likes the student with ID2. Liking someone is not necessarily mutual, so if (123, 456) is
-- in the Likes table, there is no guarantee that (456, 123) is also present.


** */







-- Q1
-- It's time for the seniors to graduate. Remove all 12th graders from Highschooler. 

DELETE FROM Highschooler
WHERE grade = 12;

-- Q2
-- If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple. 

DELETE FROM Likes
WHERE ID1 IN (SELECT L1.ID1 
	FROM Likes L1 INNER JOIN Friend F
	USING (ID1)
	WHERE L1.ID2 = F.ID2)
AND ID2 NOT IN(SELECT L1.ID1 
	FROM Likes L1 INNER JOIN Friend F
	USING (ID1)
	WHERE L1.ID2 = F.ID2);
	
	
-- Q3
-- For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. 
-- Do not add duplicate friendships, friendships that already exist, or friendships with oneself. 
-- (This one is a bit challenging; congratulations if you get it right.) 

insert into friend
select f1.id1, f2.id2
from friend f1 join friend f2 on f1.id2 = f2.id1
where f1.id1 <> f2.id2
except
select * from friend;
