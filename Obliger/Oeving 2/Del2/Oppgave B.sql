SELECT DISTINCT forlag_id FROM forlag where forlag_id not IN (SELECT DISTINCT forlag_id FROM bok) 

#brukte seleksjon da jeg kun velger unike forlag_id(strengt tatt ikke nødvendig) og differanse, da jeg sjekker hvilke som finnes i forlag men ikke i bok
