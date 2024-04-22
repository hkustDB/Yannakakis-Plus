create or replace view aggJoin4637180846581990418 as (
with aggView8201257887961639601 as (select id as v26, name as v47 from name as n where name LIKE '%B%')
select movie_id as v3, v47 from cast_info as ci, aggView8201257887961639601 where ci.person_id=aggView8201257887961639601.v26);
create or replace view aggJoin8488872351447307691 as (
with aggView4684213902622019632 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView4684213902622019632 where mk.keyword_id=aggView4684213902622019632.v25);
create or replace view aggJoin1182115448665674719 as (
with aggView1004667352641270679 as (select v3 from aggJoin8488872351447307691 group by v3)
select v3, v47 as v47 from aggJoin4637180846581990418 join aggView1004667352641270679 using(v3));
create or replace view aggJoin6754951800235472532 as (
with aggView8307820498188961916 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView8307820498188961916 where mc.company_id=aggView8307820498188961916.v20);
create or replace view aggJoin1617409977284669566 as (
with aggView976784801122293499 as (select v3 from aggJoin6754951800235472532 group by v3)
select id as v3 from title as t, aggView976784801122293499 where t.id=aggView976784801122293499.v3);
create or replace view aggJoin983265268052531886 as (
with aggView817084413321628377 as (select v3 from aggJoin1617409977284669566 group by v3)
select v47 as v47 from aggJoin1182115448665674719 join aggView817084413321628377 using(v3));
select MIN(v47) as v47 from aggJoin983265268052531886;
