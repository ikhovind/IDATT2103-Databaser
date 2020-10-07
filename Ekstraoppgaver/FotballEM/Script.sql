1.1

#Skriv ut alle kampene (31 stk.) med mdate og teamname på begge lagene i hver kamp sortert stigende etter når
#
#kampen ble spillt (dvs. finalen til slutt i resultattabellen).

#ferdig
SELECT temp.id, temp.mdate, temp.teamname, eteam.teamname FROM(
    SELECT game.id, game.mdate, eteam.teamname, game.team2
     FROM game
    JOIN eteam ON (game.team1 = eteam.id)) as temp
    JOIN eteam on(temp.team2 = eteam.id)
    ORDER BY (temp.mdate) ASC;

#1.2
#
#Finn teamname for begge lagene og totalt antall mål i hver kamp , inkl. de kampene som endte 0-0 (hvor antall mål er 0), sortert stigende etter når kampen ble spillt.

SELECT temp2.*, eteam.teamname FROM
    (SELECT goals_game_teams.*, eteam.teamname FROM
        (SELECT COUNT(player), goals_teams.mdate, goals_teams.id, goals_teams.team1, goals_teams.team2 
            FROM
                (SELECT game.id, game.mdate, game.team1, goal.player, game.team2 
                    FROM game 
                    LEFT JOIN goal 
                ON (game.id = goal.matchid)) as goals_teams
        GROUP BY(goals_teams.id)) as goals_game_teams
    JOIN eteam ON (goals_game_teams.team1 = eteam.id)) as temp2 
JOIN eteam ON (temp2.team2 = eteam.id);


#Ekstra: Finn resultatene for hver kamp inkl. de kampene som endte 0-0 (hvor antall mål er 0).

#Får null i verdiene
CREATE VIEW TeamGoalsPerMatch AS (
		(SELECT COUNT(teamid) as team_goals, matchid, teamid 
		FROM goal
		group by matchid, teamid)
		);

SELECT team1_goals.*, TeamGoalsPerMatch.team_goals as team2_goals from 
	(SELECT game.id, game.mdate, game.team1, game.team2, team_goals as team1_goals FROM 
		TeamGoalsPerMatch 
		RIGHT JOIN 
		game
		ON(TeamGoalsPerMatch.matchid = game.id and game.team1 = TeamGoalsPerMatch.teamid)) as team1_goals
	LEFT JOIN 
	TeamGoalsPerMatch 
	ON (team1_goals.id = TeamGoalsPerMatch.matchid AND team1_goals.team2 = TeamGoalsPerMatch.teamid);
#1.3
#
#List the the dates of the matches and the name of the team (teamname) in which Fernando Santos was the team coach (både team1 og team2).

#ferdig
SELECT eteam.teamname, date_team2name.mdate, date_team2name.teamname from
	(SELECT greek_matches.mdate, greek_matches.team1, eteam.teamname 
		FROM eteam 
		right JOIN 
			(SELECT mdate, team1, team2 
				FROM game 
				WHERE (game.team1
				IN (SELECT id FROM eteam WHERE coach = 'Fernando Santos') 
				OR game.team2 
				IN (SELECT id FROM eteam WHERE coach = 'Fernando Santos'))) as greek_matches 
	ON (greek_matches.team2 = eteam.id)) as date_team2name
left join eteam
on(eteam.id = date_team2name.team1)
#1.4
#
#Skriv ut alle lag (teamname) som har skåret minst 4 mål totalt, sotert (synkende) etter antall mål.

#orker ikke å joine med eteam, men ferdig
SELECT DISTINCT teamid from  
	(SELECT COUNT(teamid) as goal_count, teamid from goal
	group by (teamid)) counter
where counter.goal_count > 3
#1.5
#
#Vis alle lagene (teamname) som aldri har scoret mål.  #
 
#denne viser jo alle hmm, men ferdig
SELECT DISTINCT eteam.teamname FROM eteam
where eteam.id IN 
(SELECT goal.teamid FROM  goal);


#1.6
#
#Vis navn på spillere med teamname på alle spillere som skåret på "National Stadium".

#igjen så orker jeg ikke å joine med eteam, men ferdig
SELECT goal.player, goal.teamid from goal
where goal.matchid IN
	(SELECT id 
	from game 
	where game.stadium
	LIKE 'National Stadium%')

#1.7
#
#Vis navn på spillere med teamname som har skåret minst 3 mål sortert på antall mål.  #

#ferdig, orker ikke å joine med eteam
SELECT DISTINCT temp3.player, temp3.teamid, temp3.player_goals from
		(SELECT temp2.*, goal.teamid FROM 
			(SELECT temp.player, temp.player_goals FROM
				(SELECT COUNT(goal.player) as player_goals, goal.player 
				FROM goal
				GROUP BY (goal.player)) as temp
			WHERE temp.player_goals > 2) as temp2
		LEFT JOIN
		goal
		ON(goal.player = temp2.player)) as temp3
ORDER BY player_goals ASC 
		
	
#1.8
#
#Finn navn på spillere som kun har scoret i en kamp.
#
#ferdig
SELECT * FROM 
	(SELECT COUNT(DISTINCT goal.matchid) as tot_goals, goal.player FROM goal
	group by (goal.player)) as temp
WHERE tot_goals = 1;


#1.9
#
#Finn antall kamper som endte med seier til "hjemmelaget" dvs team1, gitt at kampen ikke endte uavgjort.
#

CREATE VIEW TeamGoalsPerMatch AS (
		(SELECT COUNT(teamid) as team_goals, matchid, teamid 
		FROM goal
		group by matchid, teamid)
		);
	#ferdig :)
SELECT count(*) from 
	(SELECT team1_goals.*, TeamGoalsPerMatch.team_goals as team2_goals from 
		(SELECT game.id, game.mdate, game.team1, game.team2, team_goals as team1_goals FROM 
			TeamGoalsPerMatch 
			RIGHT JOIN 
			game
			ON(TeamGoalsPerMatch.matchid = game.id and game.team1 = TeamGoalsPerMatch.teamid)) as team1_goals
		LEFT JOIN 
		TeamGoalsPerMatch 
		ON (team1_goals.id = TeamGoalsPerMatch.matchid AND team1_goals.team2 = TeamGoalsPerMatch.teamid)) as temp
	where (temp.team1_goals > temp.team2_goals)

#	2. Bruk tabellene fra fotball EM 2012, og skriv SQL-setninger for
#følgende oppgaver:

#2.1 VIEW

#Svar på følgende oppgave ved å opprette ett eller flere VIEW:

#Finn resultatene for hver kamp inkl. de kampene som endte 0-0 (hvor antall mål er 0):

	CREATE VIEW TeamGoalsPerMatch AS (
		(SELECT COUNT(teamid) as team_goals, matchid, teamid 
		FROM goal
		group by matchid, teamid)
		);

SELECT team1_goals.*, TeamGoalsPerMatch.team_goals as team2_goals from 
	(SELECT game.id, game.mdate, game.team1, game.team2, team_goals as team1_goals FROM 
		TeamGoalsPerMatch 
		RIGHT JOIN 
		game
		ON(TeamGoalsPerMatch.matchid = game.id and game.team1 = TeamGoalsPerMatch.teamid)) as team1_goals
	LEFT JOIN 
	TeamGoalsPerMatch 
	ON (team1_goals.id = TeamGoalsPerMatch.matchid AND team1_goals.team2 = TeamGoalsPerMatch.teamid);

 

#2.2 VIEW

#Skriv ut de lagene som har skåret flest (totalt) antall mål.

#PS! Kan være flere enn ett lag.
create view tot_goals as (
 (SELECT count(teamid)as tot, teamid FROM goal
 GROUP BY(teamid)
 order by (tot) desc))
 
 SELECT tot_goals.teamid from tot_goals 
 where tot_goals.tot IN(
 SELECT MAX(tot_goals.tot) from tot_goals )
 
#2.3 CREATE TABLE

#Opprett en ny tabell kalt 'stadium' for å lagre data over stadium, som i tillegg til en 'id' og 'stadiumname' inneholder egne attributter for 'town' og 'capacity'. Attr. 'id' skal være primærnøkkel i den nye tabellen.
DROP TABLE IF EXISTS stadium;
CREATE TABLE stadium(
   id VARCHAR (3) NOT NULL,
   name VARCHAR(30),
   town VARCHAR(30),   
   capacity INT,
   PRIMARY KEY (id)
   );
  
  show columns from stadium;

   
  #2.4 INSERT

#Skriv SQL-kode for å flytte verdiene i attr. stadium i game-tabellen over til attr. stadiumname i din nye stadium-tabellen

 #2.5 

#Vi ønsker å endre game-tabellen til å inkl. attr. id fra stadium-tabellen som en ny fremmendnøkkel.
#Skriv kode som legger til fremmednøkkelen OG setter inn riktig 'id' fra stadium-tabellen inn i oppdatert utgave av game-tabellen.

#2.6

#Slett stadium-attributtet fra game-tabellen (NB! Ikke bruke DELETE her).

#2.7

#Sjekk til slutt: Join av game-tabellen og stadium-tabellen.
