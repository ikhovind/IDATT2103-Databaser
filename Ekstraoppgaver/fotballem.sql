--1. Bruk tabellene fra fotball EM 2012, og skriv SQL-setninger for følgende oppgaver:

 

--1.1
--
--Skriv ut alle kampene (31 stk.) med mdate og teamname på begge lagene i hver kamp sortert stigende etter når
--
--kampen ble spillt (dvs. finalen til slutt i resultattabellen).
 

--1.2
--
--Finn teamname for begge lagene og totalt antall mål i hver kamp , inkl. de kampene som endte 0-0 (hvor antall mål er 0), sortert stigende etter når kampen ble spillt.
--
--Ekstra: Finn resultatene for hver kamp inkl. de kampene som endte 0-0 (hvor antall mål er 0).




SELECT COUNT(goals_teams.matchid), goals_teams.mdate, goals_teams.team1, goals_teams.team2 FROM ((SELECT goal.matchid, game.mdate, game.team1, game.team2 FROM game LEFT JOIN goal ON (game.id = goal.matchid)) as goals_teams) GROUP BY (mdate) 

--1.3
--
--List the the dates of the matches and the name of the team (teamname) in which Fernando Santos was the team coach (både team1 og team2).

SELECT greek_matches.mdate, greek_matches.team1 eteam.teamname FROM eteam LEFT JOIN (SELECT mdate, team1, team2 FROM game WHERE game.team1 IN (SELECT id FROM eteam WHERE coach = 'Fernando Santos') as greek_matches) ON (greek_matches.team2 = eteam.id)
--1.4
--
--Skriv ut alle lag (teamname) som har skåret minst 4 mål totalt, sotert (synkende) etter antall mål.
--<
--1.5
--
--Vis alle lagene (teamname) som aldri har scoret mål.  --
--1.6
--
--Vis navn på spillere med teamname på alle spillere som skåret på "National Stadium".
--
--1.7
--
--Vis navn på spillere med teamname som har skåret minst 3 mål sortert på antall mål.  --
--1.8
--
--Finn navn på spillere som kun har scoret i en kamp.
--
-- 
--
--1.9
--
--Finn antall kamper som endte med seier til "hjemmelaget" dvs team1, gitt at kampen ikke endte uavgjort.
--
-- 
--
-- 
