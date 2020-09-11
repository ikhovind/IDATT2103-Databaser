SELECT bok.tittel, bok.utgitt_aar, forlag.forlag_navn, forlag.adresse, forlag.telefon from bok right join forlag on bok.forlag_id = forlag.forlag_id 

#bruker projeksjon for å velge kun de oppgittene attributtene, bruker høyre ytterforening for å forene de på en slik måte at alle forlag blir med, selv de uten bøker, men bøker uten forlag blir ikke med

#er det forskjell på right og left join, hadde jeg ikke bare kunne satt forlag først og brukt left join for å oppnå samme resultat?
