SELECT * FROM forlag WHERE forlag_id in (SELECT forlag_id FROM bok where tittel = 'Generation X') 

#brukte seleksjon for å finne riktig bok, brukte projeksjon for å kun velge forlag_id, brukte så seleksjon for å kun få ut ett forlag
