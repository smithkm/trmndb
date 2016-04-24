drop schema public cascade;
create schema public;

create table service
(
	code varchar(4) not null primary key,
	name text not null unique
);

insert into service(code, name) values ('RMN', 'Royal Manticoran Navy');
insert into service(code, name) values ('RMMC','Royal Manticoran Marines');
insert into service(code, name) values ('RMA', 'Royal Manticoran Army');
insert into service(code, name) values ('GSN', 'Greyson Space Navy');
insert into service(code, name) values ('FS',  'Manticoran Foreign Service');
insert into service(code, name) values ('INT', 'Manticoran Intelligence Service');
insert into service(code, name) values ('RHN', 'Republic of Haven Navy');
insert into service(code, name) values ('IAN', 'Imperial Andermani Navy');
insert into service(code, name) values ('SFS', 'Sphinx Forestry Service');

create table country (
	iso2 char(2) unique,
	iso3 char(3) not null primary key,
	short_name text not null unique,
	long_name text not null unique
);

insert into country (iso2, iso3, short_name, long_name) values ('CA', 'CAN', 'Canada', 'Canada');
insert into country (iso2, iso3, short_name, long_name) values ('US', 'USA', 'United States', 'United States of America');

create table province (
	iso2 char(2) not null,
	country char(3) not null references country(iso3),
	name text not null unique,
	primary key (country, iso2)
);

insert into province (iso2, country, name) values ('BC', 'CAN', 'British Columbia');
insert into province (iso2, country, name) values ('WA', 'USA', 'Washington');

create table department (
	id integer not null,
	branch varchar(4) not null references service(code),
	name text not null,
	primary key (branch, id)
);

insert into department (id, branch, name) values (0, 'RMN', 'Command');
insert into department (id, branch, name) values (1, 'RMN', 'Administration');
insert into department (id, branch, name) values (2, 'RMN', 'Logistics');
insert into department (id, branch, name) values (3, 'RMN', 'Tactical');
insert into department (id, branch, name) values (4, 'RMN', 'Engineering');
insert into department (id, branch, name) values (5, 'RMN', 'Communications');
insert into department (id, branch, name) values (6, 'RMN', 'Astrogation');
insert into department (id, branch, name) values (7, 'RMN', 'Flight Operations');
insert into department (id, branch, name) values (8, 'RMN', 'Medical');

create table specialty (
	id integer not null,
	branch varchar(4) not null references service(code),
	department integer not null,
	name text not null,
	foreign key (branch, department) references department(branch, id),
	primary key (branch, id)
);

insert into specialty (id, branch, department, name) values (01, 'RMN', 1,'Personnelman');
insert into specialty (id, branch, department, name) values (02, 'RMN', 1,'Navy Counsellor');
insert into specialty (id, branch, department, name) values (03, 'RMN', 1,'Steward');
insert into specialty (id, branch, department, name) values (04, 'RMN', 1,'Yeoman');
insert into specialty (id, branch, department, name) values (05, 'RMN', 7,'Coxswain');
insert into specialty (id, branch, department, name) values (06, 'RMN', 6,'Helmsman');
insert into specialty (id, branch, department, name) values (07, 'RMN', 6,'Plotting Specialist');
insert into specialty (id, branch, department, name) values (08, 'RMN', 3,'Fire Control Technician');
insert into specialty (id, branch, department, name) values (09, 'RMN', 3,'Electronic Warfare Technician');
insert into specialty (id, branch, department, name) values (10, 'RMN', 3,'Tracking Specialist');
insert into specialty (id, branch, department, name) values (11, 'RMN', 5,'Data Systems Technician');
insert into specialty (id, branch, department, name) values (12, 'RMN', 5,'Electronics Technician');
insert into specialty (id, branch, department, name) values (13, 'RMN', 5,'Communication Technician');
insert into specialty (id, branch, department, name) values (14, 'RMN', 4,'Impeller Technician');
insert into specialty (id, branch, department, name) values (15, 'RMN', 4,'Power Technician');
insert into specialty (id, branch, department, name) values (16, 'RMN', 4,'Gravitics Technician');
insert into specialty (id, branch, department, name) values (17, 'RMN', 4,'Environmental Technician');
insert into specialty (id, branch, department, name) values (18, 'RMN', 4,'Hydroponics Technician');
insert into specialty (id, branch, department, name) values (19, 'RMN', 4,'Damage Control Technician');
insert into specialty (id, branch, department, name) values (20, 'RMN', 2,'Storekeeper');
insert into specialty (id, branch, department, name) values (21, 'RMN', 2,'Disbursing Clerk');
insert into specialty (id, branch, department, name) values (22, 'RMN', 2,'Ship''s Serviceman');
insert into specialty (id, branch, department, name) values (23, 'RMN', 8,'Corpsman');
insert into specialty (id, branch, department, name) values (24, 'RMN', 8,'Sick Berth Attendant');
insert into specialty (id, branch, department, name) values (25, 'RMN', 0,'Operations Specialist');
insert into specialty (id, branch, department, name) values (26, 'RMN', 0,'Intelligence Specialist');
insert into specialty (id, branch, department, name) values (27, 'RMN', 3,'Missile Technician');
insert into specialty (id, branch, department, name) values (28, 'RMN', 3,'Beam Weapons Technician');
insert into specialty (id, branch, department, name) values (29, 'RMN', 3,'Gunner');
insert into specialty (id, branch, department, name) values (30, 'RMN', 0,'Boatswain');
insert into specialty (id, branch, department, name) values (31, 'RMN', 0,'Master-at-Arms');
insert into specialty (id, branch, department, name) values (32, 'RMN', 3,'Sensor Technician');

create table course (
	code varchar not null primary key,
	branch varchar(4) not null references service(code)
);

insert into course (code, branch) select 'SIA-RMN-000'||i::text, 'RMN' from unnest(array[1,2,3,4,5,6]) as i;
insert into course (code, branch) select 'SIA-RMN-001'||i::text, 'RMN' from unnest(array[1,2,3]) as i;
insert into course (code, branch) select 'SIA-RMN-010'||i::text, 'RMN' from unnest(array[1,2,3,4,5,6]) as i;
insert into course (code, branch) select 'SIA-RMN-100'||i::text, 'RMN' from unnest(array[1,2,3,4,5]) as i;

insert into course (code, branch) select 'SIA-RMMC-000'||i::text, 'RMMC' from unnest(array[1,2,3,4,5,6]) as i;
insert into course (code, branch) select 'SIA-RMMC-001'||i::text, 'RMMC' from unnest(array[1,2,3]) as i;
insert into course (code, branch) select 'SIA-RMMC-010'||i::text, 'RMMC' from unnest(array[1,2,3,4,5,6]) as i;
insert into course (code, branch) select 'SIA-RMMC-100'||i::text, 'RMMC' from unnest(array[1,2,3,4]) as i;

insert into course (code, branch) select 'IMNA-GSN-000'||i::text, 'GSN' from unnest(array[1,2,3,4,5,6]) as i;
insert into course (code, branch) select 'IMNA-GSN-001'||i::text, 'GSN' from unnest(array[1,2,3]) as i;
insert into course (code, branch) select 'IMNA-GSN-010'||i::text, 'GSN' from unnest(array[1,2,3,4,5,6]) as i;
insert into course (code, branch) select 'IMNA-GSN-100'||i::text, 'GSN' from unnest(array[1,2,3,4,5]) as i;

insert into course (code, branch) select 'KR1MA-RMA-000'||i::text, 'RMA' from unnest(array[1,2,3,4,5,6,7,8]) as i;
insert into course (code, branch) select 'KR1MA-RMA-001'||i::text, 'RMA' from unnest(array[1,2,3,4]) as i;
insert into course (code, branch) select 'KR1MA-RMA-010'||i::text, 'RMA' from unnest(array[1,2,3,4,5,6]) as i;
insert into course (code, branch) select 'KR1MA-RMA-100'||i::text, 'RMA' from unnest(array[1,2,3,4]) as i;

insert into course (code, branch) select 'SIA-SRN-'||lpad(s::text,2,'0')||l::text, 'RMN' from (select * from ((select unnest(array[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32]) as s) as s2 cross join (select unnest(array['A', 'C', 'D', 'W']) as l) as f)) as t;
insert into course (code, branch) select 'SIA-SRMC-'||lpad(s::text,2,'0')||l::text, 'RMMC' from (select * from ((select unnest(array[1,2,3,4,5,6,7,8,9,10]) as s) as s2 cross join (select unnest(array['A', 'C', 'D', 'W']) as l) as f)) as t;
insert into course (code, branch) select 'KR1MA-RMAT-'||lpad(s::text,2,'0')||l::text, 'RMA' from (select * from ((select unnest(array[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52]) as s) as s2 
	cross join (select unnest(array['A', 'B']) as l) as f)) as t;

CREATE TYPE grade_category AS ENUM ('enlisted', 'nco', 'warrant', 'officer', 'flag');

create table grade (
	code varchar not null,
	sort integer not null,
	branch varchar not null references service(code),
	title text not null,
	abbreviation text not null,
	requires varchar references course(code),
	tig interval,
	min_age interval,
	max_age interval,
	category grade_category not null,
	primary key (code, branch),
	unique(branch, sort)
);

insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'enlisted', 'E-01', 0, 'Spacer 3rd Class', 'S3C', null);
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'enlisted', 'E-02', 1, 'Spacer 2nd Class', 'S2C', 'SIA-RMN-0001');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'enlisted', 'E-03', 2, 'Spacer 1st Class', 'S1C', 'SIA-RMN-0001');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'nco', 'E-04', 3, 'Petty Officer 3rd Class', 'PO3', 'SIA-RMN-0002');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'nco', 'E-05', 4, 'Petty Officer 2nd Class', 'PO2', 'SIA-RMN-0002');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'nco', 'E-06', 5, 'Petty Officer 1st Class', 'PO1', 'SIA-RMN-0003');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'nco', 'E-07', 6, 'Chief Petty Officer', 'CPO', 'SIA-RMN-0003');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'nco', 'E-08', 7, 'Senior Chief Petty Officer', 'SCPO', 'SIA-RMN-0004');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'nco', 'E-09', 8, 'Master Chief Petty Officer', 'MCPO', 'SIA-RMN-0005');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'nco', 'E-10', 9, 'Senior Master Chief Petty Officer', 'SMCPO', 'SIA-RMN-0006');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'nco', 'E+10', 10, 'Senior Master Chief Petty Officer of the Navy', 'SMCPON', 'SIA-RMN-0006');

insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'warrant', 'WO-01', 100, 'Warrant Officer', 'WO', 'SIA-RMN-0011');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'warrant', 'WO-02', 101, 'Warrant Officer 1st Class', 'WO1', 'SIA-RMN-0011');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'warrant', 'WO-03', 102, 'Chief Warrant Officer', 'CWO', 'SIA-RMN-0012');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'warrant', 'WO-04', 103, 'Senior Chief Warrant Officer', 'SCWO', 'SIA-RMN-0012');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'warrant', 'WO-05', 104, 'Master Chief Warrant Officer', 'MCWO', 'SIA-RMN-0013');

insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'officer', 'MID', 200, 'Midshipman', 'MID', null);

insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'officer', 'O-1', 300, 'Ensign', 'ENS', 'SIA-RMN-0101');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'officer', 'O-2', 301, 'Lieutenant (JG)', 'LT(JG)', 'SIA-RMN-0102');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'officer', 'O-3', 302, 'Lieutenant (SG)', 'LT(SG)', 'SIA-RMN-0103');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'officer', 'O-4', 303, 'Lieutenant Commander', 'LT CDR', 'SIA-RMN-0104');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'officer', 'O-5', 304, 'Commander', 'CDR', 'SIA-RMN-0105');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'officer', 'O-6A', 305, 'Captain (JG)', 'CAPT(JG)', 'SIA-RMN-0106');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'officer', 'O-6B', 306, 'Captain (SG)', 'CAPT(SG)', 'SIA-RMN-1001');

insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'flag', 'F-1', 400, 'Commodore', 'CDRE', 'SIA-RMN-1001');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'flag', 'F-2', 401, 'Rear Admiral', 'RADM', 'SIA-RMN-1002');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'flag', 'F-3', 402, 'Vice Admiral', 'VADM', 'SIA-RMN-1003');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'flag', 'F-4', 403, 'Admiral', 'ADM', 'SIA-RMN-1004');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'flag', 'F-5', 404, 'Fleet Admiral', 'FADM', 'SIA-RMN-1004');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('RMN', 'flag', 'F-6', 405, 'Admiral of the Fleet', 'ADMF', 'SIA-RMN-1004');


insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'enlisted', 'E-01', 0, 'Spacer 3rd Class', 'S3C', null);
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'enlisted', 'E-02', 1, 'Spacer 2nd Class', 'S2C', 'IMNA-GSN-0001');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'enlisted', 'E-03', 2, 'Spacer 1st Class', 'S1C', 'IMNA-GSN-0001');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'nco', 'E-04', 3, 'Petty Officer 3rd Class', 'PO3', 'IMNA-GSN-0002');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'nco', 'E-05', 4, 'Petty Officer 2nd Class', 'PO2', 'IMNA-GSN-0002');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'nco', 'E-06', 5, 'Petty Officer 1st Class', 'PO1', 'IMNA-GSN-0003');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'nco', 'E-07', 6, 'Chief Petty Officer', 'CPO', 'IMNA-GSN-0003');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'nco', 'E-08', 7, 'Senior Chief Petty Officer', 'SCPO', 'IMNA-GSN-0004');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'nco', 'E-09', 8, 'Master Chief Petty Officer', 'MCPO', 'IMNA-GSN-0005');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'nco', 'E-10', 9, 'Senior Master Chief Petty Officer', 'SMCPO', 'IMNA-GSN-0006');

insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'warrant', 'WO-01', 100, 'Warrant Officer', 'WO', 'IMNA-GSN-0011');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'warrant', 'WO-02', 101, 'Chief Warrant Officer', 'CWO', 'IMNA-GSN-0011');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'warrant', 'WO-03', 102, 'Senior Chief Warrant Officer', 'SCWO', 'IMNA-GSN-0012');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'warrant', 'WO-04', 103, 'Master Chief Warrant Officer', 'MCWO', 'IMNA-GSN-0012');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'warrant', 'WO-05', 104, 'Senior Master Chief Warrant Officer', 'SMCWO', 'IMNA-GSN-0013');

insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'officer', 'MID', 200, 'Midshipman', 'MID', null);

insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'officer', 'O-1', 300, 'Ensign', 'ENS', 'IMNA-GSN-0101');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'officer', 'O-2', 301, 'Lieutenant (JG)', 'LT(JG)', 'IMNA-GSN-0102');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'officer', 'O-3', 302, 'Lieutenant (SG)', 'LT(SG)', 'IMNA-GSN-0103');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'officer', 'O-4', 303, 'Lieutenant Commander', 'LT CDR', 'IMNA-GSN-0104');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'officer', 'O-5', 304, 'Commander', 'CDR', 'IMNA-GSN-0105');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'officer', 'O-6', 305, 'Captain', 'CAPT', 'IMNA-GSN-0106');

insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'flag', 'F-1', 400, 'Commodore', 'CDRE', 'IMNA-GSN-1001');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'flag', 'F-2', 401, 'Rear Admiral', 'RADM', 'IMNA-GSN-1002');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'flag', 'F-3', 402, 'Vice Admiral', 'VADM', 'IMNA-GSN-1003');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'flag', 'F-4', 403, 'Admiral', 'ADM', 'IMNA-GSN-1004');
insert into grade(branch, category, code, sort, title, abbreviation, requires) values ('GSN', 'flag', 'F-5', 404, 'High Admiral', 'HADM', 'IMNA-GSN-1004');

update grade set tig = interval '3 months' where code='E-02';
update grade set tig = interval '5 months' where code='E-03';
update grade set tig = interval '7 months' where code='E-04';
update grade set tig = interval '9 months' where code='E-05';
update grade set tig = interval '11 months' where code='E-06';
update grade set tig = interval '13 months' where code='E-07';
update grade set tig = interval '15 months' where code='E-08';
update grade set tig = interval '19 months' where code='E-09';
update grade set tig = interval '24 months' where code='E-10';
update grade set tig = interval '6 months' where code='WO-1';
update grade set tig = interval '9 months' where code='WO-2';
update grade set tig = interval '11 months' where code='WO-3';
update grade set tig = interval '13 months' where code='WO-4';
update grade set tig = interval '15 months' where code='WO-5';
update grade set tig = interval '6 months' where code='O-2';
update grade set tig = interval '9 months' where code='O-3';
update grade set tig = interval '12 months' where code='O-4';
update grade set tig = interval '13 months' where code='O-5';
update grade set tig = interval '15 months' where code='O-6';
update grade set tig = interval '15 months' where code='O-6A';

create table rating (
	grade varchar(5) not null,
	branch varchar(4) not null references service(code),
	specialty integer not null,
	title text not null,
	abbreviation text not null,
	requires varchar not null references course(code),
	primary key (branch, grade, specialty),
	foreign key (branch, grade) references grade(branch, code),
	foreign key (branch, specialty) references specialty(branch, id),
	unique(branch, abbreviation),
	unique(branch, title)
);

create table crew
(
	id text not null primary key,
	personal_name text not null,
	surname text not null,
	postal text,
	email text,
	phone text,
	country char(3) references country(iso3),
	province char(2),
	foreign key (country, province) references province(country, iso2),
	city text,
	birthdate date,
	branch varchar(4) references service(code)
);

create table promotion (
	crew text not null references crew(id),
	"date" date not null,
	branch varchar(4) not null references service(code),
	grade varchar(5) not null,
	specialty integer,
	category promotion_category not null,
	foreign key (branch, grade) references grade (branch, code),
	foreign key (branch, specialty) references specialty (branch, id),
	id serial not null primary key
);

create table certificate (
	code varchar not null references course(code),
	crew varchar not null references crew(id),
	"date" date not null,
	score integer not null check(score>=0 and score <=100),
	primary key (crew, code)
);

create table duty_station (
	id serial not null primary key,
	crew varchar not null references crew(id),
	"date" date not null,
	branch varchar(4) not null references service(code),
	station text not null
);


create or replace view promotion_v as select distinct on (promotion.id) promotion.*, title.title from promotion inner join ((select branch, title, code as grade, null as specialty from grade) union (select branch, title, grade, specialty from rating)) as title
		on (promotion.grade=title.grade and promotion.branch=title.branch and  (coalesce(promotion.specialty,-1)=coalesce(title.specialty) or title.specialty is null) )
		order by promotion.id,title.specialty ASC;

create or replace view crew_v as 
	select DISTINCT on (crew.id) crew.*, p.title, p.specialty, p.grade from 
		crew left join promotion_v as p on (crew.id=p.crew and crew.branch=p.branch) 
	where crew.id in (select crew as id from (select distinct on (crew) station, crew from duty_station order by crew, "date" DESC) as current_station where station='HMS Hellhound')
	order by crew.id, p.date DESC;