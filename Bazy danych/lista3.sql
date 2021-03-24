-- Karolina Jeziorska, pga

-- Zadanie 1
CREATE VIEW ranking(displayname, liczba_odpowiedzi)
AS 
SELECT users.displayname, COUNT(*)
FROM posts p1 JOIN posts p2 ON(p1.acceptedanswerid = p2.id) JOIN users ON(users.id = p2.owneruserid)
GROUP BY users.id, users.displayname
ORDER BY 2 DESC, 1;

-- Zadanie 2
SELECT users.id, users.displayname, users.reputation
FROM users JOIN 
(SELECT comments.userid AS userid, COUNT(comments.id) AS liczba
FROM comments JOIN posts ON (comments.postid = posts.id)
WHERE EXTRACT(YEAR FROM posts.creationdate) = 2020
GROUP BY userid) AS POM2 ON (users.id = userid)
WHERE users.upvotes >
(SELECT AVG(upvotes)
FROM 
(SELECT DISTINCT users.id, users.upvotes
FROM users JOIN badges ON(users.id = badges.userid)
WHERE badges.name = 'Enlightened') as POM)
AND users.id NOT IN (SELECT badges.userid
FROM badges 
WHERE badges.name = 'Enlightened')
AND liczba > 1
ORDER BY users.creationdate;

-- Zadanie 3
WITH RECURSIVE Foo(id,dn) AS
(
	SELECT users.id, users.displayname
	FROM users JOIN posts ON (users.id = posts.owneruserid)
	WHERE posts.body LIKE '%recurrence%'
	UNION
	SELECT u.id, u.displayname
	FROM Foo f JOIN posts ON(f.id = posts.owneruserid) JOIN comments ON(posts.id = comments.postid) JOIN users u ON(comments.userid = u.id)
)
SELECT * FROM Foo;


