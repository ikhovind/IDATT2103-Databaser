DROP TABLE IF EXISTS budrunde;
CREATE TABLE budrunde(
	budrundeId int PRIMARY KEY,
    navn VARCHAR(30),
    bud INTEGER NOT NULL,
    budnr INTEGER NOT NULL);    
    
   
INSERT INTO budrunde values (1, "Minimumsbud", 1200000, 1);

START TRANSACTION;
set @expected = (SELECT budnr from budrunde);
UPDATE budrunde set bud = bud + 10;
UPDATE budrunde set budnr = budnr +1;
set @realvalue = (SELECT budnr from budrunde);
set @tran = (select if(@realvalue = @expected + 1,'COMMIT','ROLLBACK'));
prepare stmt from @tran;
execute stmt;


