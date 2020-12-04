select til_stedid, fra_stedid from løp_etappe
where enr in
select enr from løp_etappe
where lnr = 1
left join sted
on(til_sted = sted_id or fra_stedit = sted_id)

-- oppgave b)
select fra_stedid, til_stedid, distanse
from etabbe
where enr IN
select enr from løp_etabbe
where lnr = 1
and aar = 2018
left join sted
on(fra_stedid = stedid OR til_stedid = stedid)

----c)
select distinct deltnr from
   select * from tidtaking
   where fullført = 1 and lnr = 1
having count(*) > 3

--d)
create view finn as(
    select deltnr, sum(tid) as tot, sum(fullført) as ant
    from tidtaking
    where lnr IN
    select lnr from løp where løpsnavn = 'Finnmarksløpet' and aar = 2018
)

--e)
select min(tot) as tid, deltnr from finn
where ant
in
select max(ant) from finn
group by(deltnr)
