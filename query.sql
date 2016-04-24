-- select title from (select code as grade, branch, null as specialty, title, abbreviation from grade UNION select grade, branch, specialty, title, abbreviation from rating) as titles where branch='RMN' and grade='E-01' and (specialty = 11 or specialty is null) ORDER BY specialty LIMIT 1;
-- select title from (select code as grade, branch, null as specialty, title, abbreviation from grade UNION select grade, branch, specialty, title, abbreviation from rating) as titles where branch='RMN' and grade='E-01' and (specialty = 11 or specialty is null) ORDER BY specialty LIMIT 1;
--with crewg as (select distinct on (promotion.crew) crew.id, personal_name, surname, crew.branch, promotion."date" as date, promotion.grade as grade,  specialty from crew left outer join promotion on (crew.id=promotion.crew) order by promotion.crew,"date" DESC )
--select id, personal_name, surname, branch, grade, (select name from specialty where specialty.branch=crewg.branch and specialty.id=crewg.specialty) as specialty,"date" as date_of_grade, now()::date-"date" as tig, 
--(select title from (select code as grade, branch, null as specialty, title, abbreviation from grade UNION select grade, branch, specialty, title, abbreviation from rating) as titles where titles.branch=crewg.branch 
--and titles.grade=crewg.grade  and (titles.specialty = crewg.specialty or specialty is null) ORDER BY titles.specialty DESC LIMIT 1) as rank from crewg;

insert into rating(branch, grade, specialty, title, abbreviation) values ('RMN', 'E-02', 11,'Data Systems Technician 2nd Class', 'DS2');

select DISTINCT on (crew.id)
	* 
	from 
		crew 
		left outer join 
		promotion 
		on (crew.id=promotion.crew and crew.branch=promotion.branch) 
		inner join ((select branch, title, code as grade, null as specialty from grade) union (select branch, title, grade, specialty from rating)) as title
		on (promotion.grade=title.grade and crew.branch=title.branch and  (coalesce(crew.specialty,-1)=coalesce(title.specialty) or title.specialty is null) ) 
	order by crew.id, date DESC, title.specialty ASC;
--select * from promotion where crew = 'RMN-2407-16' ORDER BY date DESC LIMIT 1;
--((select branch, title, code as grade, null as specialty from grade) union (select branch, title, grade, specialty from rating));


--select * from ((select branch, title, code as grade, -1 as specialty from grade) union (select branch, title, grade, coalesce(specialty,-1) from rating)) title order by title.grade