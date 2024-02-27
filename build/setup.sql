create table people (
  id smallint primary key,
  name varchar(64)
);

insert into people (id, name) values
  -- ECTs
  (1, 'Ebony'),
  (2, 'Emily'),
  (3, 'Evan'),
  (4, 'Eric'),
  (5, 'Edward'),
  (6, 'Edwin'),
  (7, 'Erica'),

  -- Mentors
  (8, 'Mary'),
  (9, 'Michael'),
  (10, 'Maud'),
  (11, 'Mandy'),
  (12, 'Michaela')
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
  person_id integer references people(id),
  school_id integer references schools(id),
  started_on date not null,
  finished_on date null
);

insert into tenureships(id, person_id, school_id, started_on, finished_on) values

  -- ects
  (1, 1, 1, '2021-09-01', null),
  (2, 2, 1, '2021-09-02', '2022-09-02'),
  (3, 3, 1, '2021-09-03', null),
  (4, 4, 1, '2021-09-04', null),
  (5, 5, 1, '2021-09-05', null),
  (6, 6, 1, '2021-09-04', null),
  (7, 7, 1, '2021-09-05', null),

  -- mentors
  (8, 8, 1, '2021-09-05', '2022-09-05'),
  (9, 9, 1, '2021-09-05', null),
  (10, 10, 1, '2021-09-05', null),
  (11, 11, 1, '2021-09-05', null),

  -- subsequent
  (12, 2, 2, '2022-09-09', null),
  (13, 8, 3, '2022-09-09', null)
;

create table mentorships (
  id integer primary key,
  mentor_id integer references tenureships(id),
  mentee_id integer references tenureships(id),
  started_on date not null,
  finished_on date null
);

insert into mentorships(id, mentor_id, mentee_id, started_on, finished_on) values
  (1, 8, 1, '2021-10-01', null),
  (2, 9, 2, '2021-10-02', '2022-09-02'),
  (3, 10, 3, '2021-10-03', null),
  (4, 11, 4, '2021-10-04', null),
  (5, 8, 5, '2021-10-05', null),
  (6, 9, 6, '2021-10-04', '2022-03-20'),
  (7, 10, 7, '2021-10-05', null)
;

create table appropriate_body_associations (
  id integer primary key,
  person_id integer references people(id),
  appropriate_body_id integer references appropriate_bodies(id),
  started_on date not null,
  finished_on date null
);

insert into appropriate_body_associations(id, person_id, appropriate_body_id, started_on, finished_on) values
  (1, 1, 1, '2021-09-08', null),
  (2, 2, 1, '2021-09-08', null),
  (3, 3, 1, '2021-09-08', '2022-09-08'),
  (4, 4, 1, '2021-09-08', null),
  (5, 5, 1, '2021-09-08', null),
  (6, 6, 1, '2021-09-08', '2022-09-09'),
  (7, 7, 1, '2021-09-08', '2022-09-10')
;

create table delivery_partner_associations (
  id integer primary key,
  person_id integer references people(id),
  delivery_partner_id integer references delivery_partners(id),
  started_on date not null,
  finished_on date null
);

insert into delivery_partner_associations(id, person_id, delivery_partner_id, started_on, finished_on) values
  (1, 1, 1, '2021-09-08', null),
  (2, 2, 1, '2021-09-08', '2022-09-08'),
  (3, 3, 2, '2021-09-08', null),
  (4, 4, 2, '2021-09-08', null),
  (5, 5, 2, '2021-09-08', null),
  (6, 6, 1, '2021-09-08', null),
  (7, 7, 1, '2021-09-08', '2022-09-09')
;

create table lead_provider_associations (
  id integer primary key,
  person_id integer references people(id),
  lead_provider_id integer references lead_providers(id),
  started_on date not null,
  finished_on date null
);

insert into lead_provider_associations(id, person_id, lead_provider_id, started_on, finished_on) values
  (1, 1, 1, '2021-10-08', null),
  (2, 2, 1, '2021-10-08', null),
  (3, 3, 1, '2021-10-08', '2023-01-05'),
  (4, 4, 1, '2021-10-08', null),
  (5, 5, 1, '2021-10-08', '2023-01-05'),
  (6, 6, 1, '2021-10-08', null),
  (7, 7, 1, '2021-10-08', null)
;
