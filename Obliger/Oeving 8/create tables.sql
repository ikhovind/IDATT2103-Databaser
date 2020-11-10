SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS kunde;
DROP TABLE IF EXISTS ordre;
DROP TABLE IF EXISTS lagerplukking;
DROP TABLE IF EXISTS bestilling;
DROP TABLE IF EXISTS lagerplukking_vare;
DROP TABLE IF EXISTS bestilling_vare;
DROP TABLE IF EXISTS vare;
DROP TABLE IF EXISTS leverandør;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE kunde(
    kunde_nr INTEGER PRIMARY KEY AUTO_INCREMENT,
    etternavn VARCHAR(20),
    fornavn VARCHAR(15),
    tlf VARCHAR(10),
    kreditt VARCHAR(20)
);

CREATE TABLE leverandør(
    lev_nr INTEGER PRIMARY KEY AUTO_INCREMENT,
    navn VARCHAR(25),
    adresse VARCHAR(45)
);

CREATE TABLE ordre(
    ordre_nr INTEGER PRIMARY KEY AUTO_INCREMENT,
    ordre_status VARCHAR(30),
    rabatt DECIMAL(3, 2),
    bestillings_dato DATE,
    kunde_nr INTEGER,

    FOREIGN KEY (kunde_nr) REFERENCES kunde(kunde_nr)
);

CREATE TABLE vare(
    NOBB_nummer INTEGER PRIMARY KEY,
    lagerbeholdning INTEGER,
    innkjøpspris INTEGER,
    salgspris INTEGER,
    navn VARCHAR(200),
    beskrivelse VARCHAR(1),
    lev_nr INTEGER,

    FOREIGN KEY (lev_nr) REFERENCES leverandør(lev_nr)
);

CREATE TABLE lagerplukking(
    ordre_nr INTEGER PRIMARY KEY,
    plukking_status VARCHAR(30),
    plukkes_av VARCHAR(25),

    FOREIGN KEY (ordre_nr) REFERENCES ordre(ordre_nr)
);

CREATE TABLE lagerplukking_vare(
    ordre_nr INTEGER PRIMARY KEY,
    NOBB_nummer INTEGER,
    antall INTEGER,

    FOREIGN KEY (ordre_nr) REFERENCES ordre(ordre_nr),
    FOREIGN KEY (NOBB_nummer) REFERENCES vare(NOBB_nummer)
);

CREATE TABLE bestilling(
    bestillingsnummer INTEGER PRIMARY KEY AUTO_INCREMENT,
    leverings_dato INTEGER,
    ordre_nr INTEGER,

    FOREIGN KEY (ordre_nr) REFERENCES ordre(ordre_nr)
);

CREATE TABLE bestilling_vare(
    bestillingsnummer INTEGER,
    NOBB_nummer INTEGER,
    antall INTEGER,

    FOREIGN KEY (bestillingsnummer) REFERENCES bestilling(bestillingsnummer),
    FOREIGN KEY (NOBB_nummer) REFERENCES vare(NOBB_nummer),
    PRIMARY KEY (bestillingsnummer, NOBB_nummer)
);
