-- 'open' induction records (ects with a AB and mentor) as of today's date
select
  ects.name,
  mentors.name as current_mentor_name,
  ms.started_on as mentorship_started_on,
  ab.name as current_ab,
  aba.started_on as appropriate_body_since
from
  participants ects
-- joins to get the current AB
inner join appropriate_body_associations aba
  on ects.id = aba.participant_id
  and current_date between aba.started_on and coalesce(aba.finished_on, current_date)
inner join appropriate_bodies ab 
  on aba.appropriate_body_id = ab.id
-- joins to get the current mentor
inner join mentorships ms
  on ects.id = ms.mentee_id
  and current_date between ms.started_on and coalesce(ms.finished_on, current_date)
inner join participants mentors
  on ms.mentor_id = mentors.id;

-- induction records (ects with a AB and mentor) at a date in the past
select
  ects.id,
  ects.name,
  mentors.name as current_mentor_name,
  ms.started_on as mentor_since,
  ms.finished_on as mentor_until,
  ab.name as current_ab,
  aba.started_on as appropriate_body_since,
  aba.finished_on as appropriate_body_until
from
  participants ects
-- joins to get the current AB
inner join appropriate_body_associations aba
  on ects.id = aba.participant_id
  and '2022-02-02' between aba.started_on and coalesce(aba.finished_on, current_date)
inner join appropriate_bodies ab 
  on aba.appropriate_body_id = ab.id
-- joins to get the current mentor
inner join mentorships ms
  on ects.id = ms.mentee_id
  and '2022-02-02' between ms.started_on and coalesce(ms.finished_on, current_date)
inner join participants mentors
  on ms.mentor_id = mentors.id;
