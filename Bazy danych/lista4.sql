-- Karolina Jeziorska, pga
-- Zadanie 1
ALTER TABLE comments
ADD lasteditdate timestamp NOT NULL DEFAULT now();
UPDATE comments 
SET lasteditdate = creationdate;

CREATE TABLE commenthistory(
id SERIAL PRIMARY KEY,
commentid integer,
creationdate timestamp,
text text);

-- Zadanie 2
CREATE OR REPLACE FUNCTION on_update_comments() RETURNS TRIGGER AS $X$
BEGIN
	IF (NEW.id <> OLD.id OR NEW.postid <> OLD.postid OR NEW.lasteditdate <> OLD.lasteditdate) THEN 
		RAISE EXCEPTION 'Invalid update.' USING HINT = 'Cannot change id, postid or lasteditdate'; 
	END IF;

	NEW.creationdate = OLD.creationdate;

	IF (NEW.text <> OLD.text) THEN 
		NEW.lasteditdate = now();
		INSERT INTO commenthistory(commentid, creationdate, text) VALUES (OLD.id, OLD.lasteditdate, OLD.text);
	END IF;

	RETURN NEW; 
END
$X$ LANGUAGE plpgsql;

CREATE TRIGGER on_update_comments BEFORE UPDATE ON comments
FOR EACH ROW EXECUTE PROCEDURE on_update_comments();


-- Zadanie 3
CREATE OR REPLACE FUNCTION on_insert_comments() RETURNS TRIGGER AS $X$
BEGIN
	NEW.lasteditdate = NEW.creationdate;      
END
$X$ LANGUAGE plpgsql;

CREATE TRIGGER on_insert_comments BEFORE INSERT ON comments
FOR EACH ROW EXECUTE PROCEDURE on_insert_comments();


