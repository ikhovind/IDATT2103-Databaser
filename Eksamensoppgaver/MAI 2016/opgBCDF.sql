CREATE TABLE VURDERING(
vurd_id INTEGER,
kundeid INTEGER NOT NULL,
varenr INTEGER NOT NULL,
omtale TEXT,
anbefaling BOOLEAN,
CONSTRAINT pk_vurdering PRIMARY KEY(vurd_id));

CREATE TABLE VURD_KRITERIUM(
krit_id INTEGER,
navn CHAR(30) NOT NULL,
maks_score DECIMAL(3,1) NOT NULL,
CONSTRAINT pk_krit PRIMARY KEY(krit_id));
CREATE TABLE VARE_KRITERIUM(
varenr INTEGER,
krit_id INTEGER,
CONSTRAINT pk_varekrit PRIMARY KEY(varenr, krit_id));
CREATE TABLE VURD_SCORE(
vurd_id INTEGER,
krit_id INTEGER,
score DECIMAL(3,1) NOT NULL,
CONSTRAINT pk_vurdscore PRIMARY KEY(vurd_id, krit_id));
ALTER TABLE VARE_KRITERIUM
ADD CONSTRAINT krit_fk1 FOREIGN KEY(krit_id)
REFERENCES VURD_KRITERIUM (krit_id);
ALTER TABLE VURD_SCORE
ADD CONSTRAINT vurdscore_fk1 FOREIGN KEY(vurd_id)
REFERENCES VURDERING (vurd_id);
ALTER TABLE VURD_SCORE
ADD CONSTRAINT vurdscore_fk2 FOREIGN KEY(krit_id)
REFERENCES VURD_KRITERIUM (krit_id);

-- oppgave c
-- går her ut ifra at hver kunde ikke kan vurdere en vare mer enn en gang
select * from 
select count * as ant_vurderinger, vurdering_varer.navn, vurdering_varer.VareID, vurdering_varer.pris from vurdering varer
    Select * from Vurdering
    left join vurdering
    on(vare.vareID = vurdering.vareID) as vurdering_varer
group by(vareID) as vare_with_count
where(ant_vurderinger > 2)
Order by ant_vurderinger desc

-- Oppgave d
select max(score) as score, krit_id, vurd_id from vurd_kriterium
select * from
select * from vurdering
left join vurd_score
on(vurd_id = vurd_id) as vurdScore
left join vurd_kriterium
on(krit_id = krit_id) as vurdScoreKrit
group by(krit_id)

