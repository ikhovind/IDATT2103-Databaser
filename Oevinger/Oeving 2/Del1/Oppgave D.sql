#Unionkompatibelhet kreves av union og differanse og union

SELECT * FROM bok UNION SELECT * FROM forlag
SELECT * FROM bok UNION SELECT * FROM konsulent

#disse to spørringene gir oss alle tuplene i hver av de to tabllene, men dersom man spesifiserer kolonne istedenfor å bare oppgi *, så vil man kunne få svar på hvor mange unike felt som finnes. Spesielt brukbart dersom man har to kolonner som inneholder samme data som ikke er primærnøkler slik at den kan inneholde duplikater i begge tabellene. F.eks. ansatttabell og kundetabell, man vil finne alle unike fornavn

