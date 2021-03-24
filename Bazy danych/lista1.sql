-- Karolina Jeziorska, pga
-- Zadanie 1
SELECT creationdate
FROM posts
WHERE body LIKE '%Turing%'
ORDER BY 1 DESC;
-- Zadanie 2
SELECT id, title
FROM posts
WHERE title IS NOT NULL AND score >= 9 AND creationdate > '10/10/2018' AND EXTRACT(MONTH FROM creationdate) BETWEEN 9 AND 12
ORDER BY title;
-- Zadanie 3
SELECT DISTINCT users.displayname, users.reputation
FROM posts JOIN users ON(posts.owneruserid = users.id) JOIN comments ON (comments.postid = posts.id) 
WHERE posts.body LIKE '%deterministic%' AND comments.text LIKE '%deterministic%'ORDER BY users.reputation desc;
-- Zadanie 4
SELECT DISTINCT RESULT.displayname FROM ((SELECT users.id, displayname
FROM posts JOIN users ON(posts.owneruserid = users.id))
EXCEPT
(SELECT users.id, displayname
FROM comments JOIN users ON(comments.userid = users.id))) as RESULT
ORDER BY 1
LIMIT 10;

