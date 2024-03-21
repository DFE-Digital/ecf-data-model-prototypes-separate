-- at any school
select p.name, s.name, r.started_on
from participants p
inner join rosters r on p.id = r.participant_id
inner join schools s on r.school_id = s.id
where r.finished_on is null;

-- at a particular school
select p.name, s.name, r.started_on
from participants p
inner join rosters r on p.id = r.participant_id
inner join schools s on r.school_id = s.id
where r.finished_on is null
and s.name = 'Springfield Elementary';
