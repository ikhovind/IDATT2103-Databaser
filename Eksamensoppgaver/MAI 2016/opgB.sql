-- oppgave c 
-- går her ut ifra at hver kunde ikke kan vurdere en vare mer enn en gang
create view merEnn3 as(
select * from 
select count * as ant_vurderinger, vurdering_varer.navn, vurdering_varer.VareID, vurdering_varer.pris from vurdering varer
    Select * from Vurdering
    left join vurdering
    on(vare.vareID = vurdering.vareID) as vurdering_varer
group by(vareID) as vare_with_count
where(ant_vurderinger > 2)
Order by ant_vurderinger desc
)

-- Oppgave D
