USE ikhovind;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS kvalifikasjon;
DROP TABLE IF EXISTS kandidat;
DROP TABLE IF EXISTS sluttatest_mal;
DROP TABLE IF EXISTS bedrift;
DROP TABLE IF EXISTS kandidat_kvalifikasjon;
DROP TABLE IF EXISTS oppdrag;
SET FOREIGN_KEY_CHECKS=1;

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
 sluttdato DATE default NULL,
 #hvert oppdrag må være bestilt av av et org-nummer
 org_nummer INTEGER NOT NULL,
 kvalifikasjon_id INTEGER,
 kandidat_id INTEGER,
 ant_timer INTEGER DEFAULT 0,
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

insert into kvalifikasjon values (1,'Truckførerbevis');
insert into kvalifikasjon values (2, 'Førerkort klasse B');
insert into kvalifikasjon values (3, 'Fagbrev');

insert into kandidat values (1, 'Ingebrigt', 'Hovind', 123, '123@gmail.com');
insert into kandidat values (2, 'Jonas', 'Thomassen', 1234, '1234@gmail.com');
insert into kandidat values (3, 'Runar', 'Ness', 12345, '12345@gmail.com');

insert into sluttatest_mal values (1, 'Vellykket arbeid :)');

insert into bedrift values (1, 'Byggmakker', 5280, 'byggmakker@gmail.com');
insert into bedrift values (2, 'Linde', 5290, 'Linde@gmail.com');
insert into bedrift values (3, 'NTNU', 5300, 'NTNU@gmail.com');

insert into oppdrag values (1, DATE('2020-03-12'), default, 3, NULL, 1, default);
insert into oppdrag values (2, DATE('2020-05-12'), default, 2, 1, 2, default);
insert into oppdrag values (3, DATE('2020-05-12'), DATE('2020-08-14'), 3, 2, 2, 9);
insert into oppdrag values (4, DATE('2020-05-17'), DATE('2020-08-19'), 3, default, 2, 29);

insert into kandidat_kvalifikasjon values(1, 1);
insert into kandidat_kvalifikasjon values (2, 2);
insert into kandidat_kvalifikasjon values (2, 3);