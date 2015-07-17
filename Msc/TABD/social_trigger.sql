DROP FUNCTION IF EXISTS make_likes() CASCADE;

CREATE FUNCTION make_likes() RETURNS trigger AS $$
  BEGIN
    INSERT INTO "social_network".Likes
      SELECT NEW.ID, ID
      FROM "social_network".Highschooler
      WHERE (grade = NEW.grade AND ID != NEW.ID);

      RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS make_likes ON "social_network".Highschooler CASCADE;

CREATE TRIGGER make_likes AFTER INSERT OR UPDATE ON "social_network".Highschooler
FOR EACH ROW WHEN (NEW.name like 'Friendly')
EXECUTE PROCEDURE make_likes();
