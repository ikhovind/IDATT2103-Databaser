SELECT tittel from bok 
WHERE bok.bok_id in 

(select bok_id from bok_forfatter 
where bok_forfatter.forfatter_id in 

(SELECT forfatter.forfatter_id FROM forfatter 
WHERE etternavn = 'Hamsun'))


#bruker projeksjon for å velge kun tittel og forksjellige ID
#bruker seleksjon for når jeg spesifiserer hvilke id de tuplene jeg vil hente ut skal ha

#finnes det mer optimale måter å hente ut dette på? noe vis man slipper 3 selects?
