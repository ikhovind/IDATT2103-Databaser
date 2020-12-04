use ikhovind;
#oppgave 1
SELECT navn, telefon, epost from bedrift;
#oppgave 2
select oppdrag_id, org_nummer, navn, telefon
from oppdrag
left join bedrift b on b.orgnummer = oppdrag.org_nummer;
#oppgave 3
create view kand_kvalik_besk as
    (select k.kvalifikasjon_id, kandidat_id, beskrivelse from kandidat_kvalifikasjon
    left join kvalifikasjon k on kandidat_kvalifikasjon.kvalifikasjon_id = k.kvalifikasjon_id);

select kandidat.kandidat_id, kandidat.fornavn, etternavn, kkb.beskrivelse, kvalifikasjon_id
from kandidat
right join kand_kvalik_besk kkb on kandidat.kandidat_id = kkb.kandidat_id;
#oppgave 4
select kandidat.kandidat_id, kandidat.fornavn, etternavn, kkb.beskrivelse, kvalifikasjon_id
from kandidat
left join kand_kvalik_besk kkb on kandidat.kandidat_id = kkb.kandidat_id;
#oppgave 5
drop view if exists ferdig_oppdrag;
create view ferdig_oppdrag as(
select kandidat_id,startdato, sluttdato, oppdrag_id, org_nummer, beskrivelse from
    (select *
    from oppdrag
    join
        (select beskrivelse
        from sluttatest_mal) as smb)
    as malOpp
where sluttdato IS NOT NULL);

select fornavn, etternavn, startdato, sluttdato, oppdrag_id, beskrivelse, bedrift.navn from
(select fornaovn, etternavn,startdato, sluttdato, oppdrag_id, beskrivelse, org_nummer
from ferdig_oppdrag
left join kandidat k on ferdig_oppdrag.kandidat_id = k.kandidat_id
where ferdig_oppdrag.kandidat_id = 2) as kand2_ferdig
left join bedrift
on bedrift.orgnummer = kand2_ferdig.org_nummer;
