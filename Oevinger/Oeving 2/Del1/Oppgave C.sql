SELECT * FROM bok, forlag WHERE (bok.forlag_id = forlag.forlag_id);
#Denne gir alle bøkene, da det ikke finnes en eneste bok der forlag_id = NULL
SELECT * FROM bok NATURAL JOIN forlag
#denne gir samme tabell som over, da bok og forlag har samme navn på kolonnen som brukes til å samle de, dvs. forlag_id