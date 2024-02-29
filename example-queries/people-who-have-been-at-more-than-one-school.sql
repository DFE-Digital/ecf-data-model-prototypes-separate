-- the people who've been at two or more schools
select p.name, count(*)
from people p
inner join tenureships t on p.id = t.person_id
inner join schools s on t.school_id = s.id
group by p.name
having count(*) > 1;

-- the people and the schools they've been at in a list
select p.name, string_agg(s.name, ', ')
from people p
inner join tenureships t on p.id = t.person_id
inner join schools s on t.school_id = s.id
group by p.name;
