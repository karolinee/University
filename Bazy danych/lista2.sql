-- Karolina Jeziorska, pga
-- Zadanie 1
SELECT users.id, users.displayname, users.reputation, COUNT(DISTINCT posts.id) 
FROM posts JOIN postlinks ON(postlinks.postid=posts.id) JOIN users ON(users.id = posts.owneruserid)
WHERE linktypeid=3 AND relatedpostid IN(SELECT id FROM posts)
GROUP BY users.id, users.displayname, users.reputation
ORDER BY count DESC, users.displayname
LIMIT 20;

-- Zadanie 2
SELECT users.id, users.displayname, users.reputation, COUNT(comments.id), AVG(comments.score)
FROM users JOIN badges ON(users.id = badges.userid) LEFT JOIN posts ON(users.id = posts.owneruserid) LEFT JOIN comments ON(comments.postid = posts.id)
WHERE badges.name = 'Fanatic'
GROUP BY users.id, users.displayname, users.reputation
HAVING COUNT(comments.id) <= 100
ORDER BY COUNT DESC, users.displayname
LIMIT 20;

-- Zadanie 3
ALTER TABLE users ADD PRIMARY KEY (id);
ALTER TABLE badges ADD CONSTRAINT userid_fkey FOREIGN KEY (userid) REFERENCES users (id);
ALTER TABLE posts DROP COLUMN viewcount;
DELETE FROM posts WHERE body='' OR body IS NULL;

--Zadanie 4
CREATE SEQUENCE post_id;
SELECT setval('post_id',max(posts.id)) FROM posts;
ALTER TABLE posts ALTER COLUMN id SET DEFAULT nextval('post_id');
ALTER SEQUENCE post_id OWNED BY posts.id;

INSERT INTO posts(posttypeid, parentid, owneruserid, body, score, creationdate)
SELECT 3, postid, userid, text, score, creationdate
FROM comments;



