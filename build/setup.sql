create table participants (
  id smallint primary key,
  name varchar(64)
);

insert into participants (id, name) values
  -- ECTs
  (1, 'Ebony'),
  (2, 'Emily'),
  (3, 'Evan'),
  (4, 'Eric'),
  (5, 'Edward'),
  (6, 'Edwin'),
  (7, 'Erica'),
  (8, 'Ellie'),
  (9, 'Elizabeth'),
  (10, 'Eleanor'),
  (11, 'Ebenezer'),
  (12, 'Eddy'),
  (13, 'Emilia'),

  -- Mentors
  (20, 'Mary'),
  (21, 'Michael'),
  (22, 'Maud'),
  (23, 'Mandy'),
  (24, 'Michaela')
;

create table cohorts (
  start_year smallint primary key
);

insert into cohorts (start_year) values
  (2022),
  (2023),
  (2024)
;

create table schools (
  id smallint primary key,
  name varchar(64)
);

insert into schools (id, name) values
  (1, 'Springfield Elementary'),
  (2, 'Grange Hill'),
  (3, 'Sunnydale High'),
  (4, 'Bayside High')
;

create table appropriate_bodies (
  id smallint primary key,
  name varchar(64)
);

insert into appropriate_bodies(id, name) values
  (1, 'Northern Teaching School Hub'),
  (2, 'Southern Induction Panel')
;

create table delivery_partners (
  id integer primary key,
  name varchar(64)
);

insert into delivery_partners(id, name) values
  (1, 'Excellence Trust'),
  (2, 'Greatest Education Institute'),
  (3, 'Ultimate Academy Group')
;

create table lead_providers (
  id integer primary key,
  name varchar(64)
);

insert into lead_providers(id, name) values
  (1, 'AI'),
  (2, 'BPN'),
  (3, 'TF')
;

create table tenureships (
  id integer primary key,
  participant_id integer references participants(id),
  school_id integer references schools(id),
  started_on date not null,
  finished_on date null
);

insert into tenureships(id, participant_id, school_id, started_on, finished_on) values

  -- ects
  (1, 1, 1, '2021-09-01', null),
  (2, 2, 1, '2021-09-02', '2022-09-02'),
  (3, 3, 1, '2021-09-03', null),
  (4, 4, 1, '2021-09-04', null),
  (5, 5, 1, '2021-09-05', null),
  (6, 6, 1, '2021-09-04', null),
  (7, 7, 1, '2021-09-05', null),
  (8, 8, 2, '2021-09-06', null),

  (9, 9, 2, '2022-09-01', null),
  (10, 10, 2, '2022-09-02', null),
  (11, 11, 2, '2022-09-03', null),
  (12, 12, 2, '2022-09-04', null),
  (13, 13, 2, '2022-09-05', '2022-12-04'),

  -- mentors
  (20, 20, 1, '2021-09-05', '2022-09-05'),
  (21, 21, 1, '2021-09-05', null),
  (22, 22, 1, '2021-09-05', null),
  (23, 23, 1, '2021-09-05', null),

  -- subsequent
  (30, 2, 2, '2022-09-09', '2023-04-05'),
  (31, 2, 4, '2023-06-01', null),
  (32, 8, 3, '2022-09-09', null),
  (33, 13, 4, '2023-01-10', '2024-02-03')
;

create table mentorships (
  id integer primary key,
  mentor_id integer references tenureships(id) null,
  mentee_id integer references tenureships(id) not null,
  started_on date not null,
  finished_on date null
);

insert into mentorships(id, mentor_id, mentee_id, started_on, finished_on) values
  (1, 20, 1, '2021-10-01', null),
  (2, 21, 2, '2021-10-02', '2022-09-02'),
  (3, null, 3, '2021-10-03', null),
  (4, 23, 4, '2021-10-04', null),
  (5, 20, 5, '2021-10-05', null),
  (6, 20, 6, '2021-10-04', '2022-03-20'),
  (7, 21, 7, '2021-10-05', null),
  (8, null, 8, '2021-10-05', null),
  (9, 20, 9, '2021-10-05', null),
  (10, 20, 10, '2021-10-05', '2022-03-09'),
  (11, null, 11, '2021-10-05', null),
  (12, 23, 12, '2021-10-05', null),
  (13, 22, 13, '2021-10-05', null)
;

create table appropriate_body_associations (
  id integer primary key,
  participant_id integer references participants(id),
  appropriate_body_id integer references appropriate_bodies(id),
  started_on date not null,
  finished_on date null
);

insert into appropriate_body_associations(id, participant_id, appropriate_body_id, started_on, finished_on) values
  (1, 1, 1, '2021-09-08', null),
  (2, 2, 1, '2021-09-08', null),
  (3, 3, 1, '2021-09-08', '2022-09-08'),
  (4, 4, 1, '2021-09-08', null),
  (5, 5, 1, '2021-09-08', null),
  (6, 6, 1, '2021-09-08', '2022-09-09'),
  (7, 7, 2, '2021-09-08', '2022-09-10'),
  (8, 8, 2, '2022-09-08', null),
  (9, 9, 2, '2022-09-08', null),
  (10, 10, 2, '2022-09-08', null),
  (11, 11, 1, '2022-09-08', '2023-06-11'),
  (12, 12, 1, '2022-09-08', '2023-07-12'),
  (13, 13, 1, '2022-09-08', null)
;

create table provider_relationships (
  id integer primary key,
  delivery_partner_id integer references delivery_partners(id),
  lead_provider_id integer references lead_providers(id),
  cohort integer references cohorts(start_year)
);

create unique index unique_provider_relationships on provider_relationships(
  delivery_partner_id,
  lead_provider_id,
  cohort
);

insert into provider_relationships(id, delivery_partner_id, lead_provider_id, cohort) values
  (1,  1, 1, 2022),
  (2,  2, 1, 2022),
  (3,  3, 2, 2022),
  (4,  3, 3, 2022),

  (10,  1, 1, 2023),
  (11,  2, 1, 2023),
  (12,  3, 2, 2023),
  (13,  3, 3, 2023)
;

create table participants_provider_relationships (
  id integer primary key,
  provider_relationship_id integer references provider_relationships(id),
  participant_id integer references participants(id),
  started_on date not null,
  finished_on date null
);

insert into participants_provider_relationships(id, provider_relationship_id, participant_id, started_on, finished_on) values
  (1, 1, 1, '2022-09-08', null),
  (2, 1, 2, '2022-09-09', null),
  (3, 1, 3, '2022-09-10', null),
  (4, 1, 4, '2022-09-11', null),
  (5, 3, 5, '2022-09-12', '2023-09-14'),
  (6, 3, 6, '2022-09-13', null),
  (7, 3, 7, '2022-09-13', null),

  (10, 10, 8, '2023-09-10', null),
  (11, 10, 9, '2023-09-11', null),
  (12, 11, 10, '2023-09-12', null),
  (13, 11, 11, '2023-09-13', '2024-01-08'),
  (14, 12, 12, '2023-09-13', null),
  (15, 13, 13, '2023-09-13', null)
;
