

-- SQL 1 | Finne antall forskjellige varer i ordre 1506527 som er på lager
SELECT count(*)
FROM
    (SELECT lagerplukking.ordre_nr, NOBB_nummer FROM lagerplukking
    LEFT JOIN lagerplukking_vare
    ON(lagerplukking.ordre_nr = lagerplukking_vare.ordre_nr
    AND lagerplukking.ordre_nr = 1506527)) as onNn
GROUP BY(NOBB_nummer);

-- SQL 2 | Finn ordrenummer koblet til en kunde som ikke har med dette selv
SELECT o.ordre_nr, o.bestillings_dato, k.kunde_nr, k.tlf
FROM ordre o LEFT JOIN kunde k
ON(o.kunde_nr = k.kunde_nr AND k.etternavn = '' AND k.fornavn = '');

-- SQL 3 | Finne total verdi som en kunde har bestilt varer for
DROP VIEW IF EXISTS bestilling_totpris;
CREATE VIEW bestilling_totpris AS(
SELECT SUM(linjepriser.tot_vare_pris) AS tot_bestilling_pris, bestilling.ordre_nr, bestilling.bestillingsnummer
    from
    (SELECT bestillingsnummer, antall * salgspris AS tot_vare_pris FROM bestilling_vare
    LEFT JOIN vare
    ON(bestilling_vare.NOBB_nummer = vare.NOBB_nummer)
    ) AS linjepriser
RIGHT JOIN bestilling
ON(linjepriser.bestillingsnummer = bestilling.bestillingsnummer)
GROUP BY(bestillingsnummer)
);

DROP VIEW IF EXISTS plukking_totpris;
CREATE VIEW plukking_totpris AS(
SELECT SUM(linjepriser.tot_vare_pris) AS tot_plukking_pris, lagerplukking.ordre_nr
    from
    (SELECT ordre_nr, antall * salgspris AS tot_vare_pris FROM lagerplukking_vare
    LEFT JOIN vare
    ON(lagerplukking_vare.NOBB_nummer = vare.NOBB_nummer)
    ) AS linjepriser
RIGHT JOIN lagerplukking
ON(linjepriser.ordre_nr = lagerplukking.ordre_nr)
GROUP BY(ordre_nr)
);

SELECT bts.kanskje + pon.plukkepris as totSumKunde
FROM (
         SELECT sum(tot_bestilling_pris) as kanskje
         FROM bestilling_totpris
         WHERE bestilling_totpris.ordre_nr IN (
             SELECT ordre_nr
             FROM ordre
             WHERE kunde_nr = 123456)
     ) AS bts
    JOIN
    (SELECT sum(tot_plukking_pris) AS plukkepris FROM plukking_totpris
        WHERE
            plukking_totpris.ordre_nr IN (
                SELECT ordre_nr FROM ordre WHERE kunde_nr = 123456)) as pon
;