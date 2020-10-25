USE ikhovind;
DROP TABLE IF EXISTS kvalifikasjon;
DROP TABLE IF EXISTS kandidat;
DROP TABLE IF EXISTS sluttatest_mal;
DROP TABLE IF EXISTS bedrift;
DROP TABLE IF EXISTS kandidat_kvalifikasjon;

CREATE TABLE kvalifikasjon(
 kvalifikasjon_id INTEGER NOT NULL AUTO_INCREMENT,
 beskrivelse VARCHAR(30),
CONSTRAINT kvalifikasjon_pk PRIMARY KEY(kvalifikasjon_id));
#hva betyr kvalifikasjon_pk her? er det navnet til constrainten man lager når man sier hva som er pk?

CREATE TABLE kandidat(
 kandidat_id INTEGER NOT NULL AUTO_INCREMENT,
 fornavn  VARCHAR(15),
 etternavn VARCHAR(15),
 telefon INTEGER,
 epost VARCHAR(30),
CONSTRAINT kandidat_pk PRIMARY KEY(kandidat_id)

);

CREATE TABLE sluttatest_mal(
 mal_id INTEGER NOT NULL AUTO_INCREMENT,
 beskrivelse  VARCHAR(30),
CONSTRAINT attest_pk PRIMARY KEY(mal_id));

CREATE TABLE bedrift(
 orgnummer INTEGER NOT NULL,
 navn VARCHAR(30),
 telefon INTEGER,
 epost VARCHAR(30),
CONSTRAINT org_pk PRIMARY KEY(orgnummer));

CREATE TABLE oppdrag(
 oppdrag_id INTEGER NOT NULL AUTO_INCREMENT,
 startdato DATE,
 sluttdato DATE,
 ant_timer INTEGER DEFAULT 0,
 org_nummer INTEGER,
 kandidat_id INTEGER,
 kvalifikasjon_id INTEGER,
CONSTRAINT oppdrag_pk PRIMARY KEY(oppdrag_id),
FOREIGN KEY (org_nummer) REFERENCES bedrift(orgnummer),
FOREIGN KEY (kandidat_id) REFERENCES kandidat(kandidat_id),
FOREIGN KEY (kvalifikasjon_id) REFERENCES kvalifikasjon(kvalifikasjon_id)

);

CREATE TABLE kandidat_kvalifikasjon(
 kandidat_id INTEGER,
 kvalifikasjon_id INTEGER,
CONSTRAINT forlag_pk PRIMARY KEY(kandidat_id, kvalifikasjon_id),
FOREIGN KEY (kandidat_id) REFERENCES kandidat(kandidat_id),
FOREIGN KEY (kvalifikasjon_id) REFERENCES kvalifikasjon(kvalifikasjon_id)
);

