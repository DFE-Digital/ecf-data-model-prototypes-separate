-- at any school
select p.name, s.name, t.started_on
from people p
inner join tenureships t on p.id = t.person_id
inner join schools s on t.school_id = s.id
where t.finished_on is null;

-- at a particular school
select p.name, s.name, t.started_on
from people p
inner join tenureships t on p.id = t.person_id
inner join schools s on t.school_id = s.id
where t.finished_on is null
and s.name = 'Springfield Elementary';
