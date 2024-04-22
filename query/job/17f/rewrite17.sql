create or replace view aggJoin773050753077782571 as (
with aggView4094412290536583479 as (select id as v26, name as v47 from name as n where name LIKE '%B%')
select movie_id as v3, v47 from cast_info as ci, aggView4094412290536583479 where ci.person_id=aggView4094412290536583479.v26);
create or replace view aggJoin3326409462342390383 as (
with aggView4540803120596567678 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView4540803120596567678 where mk.keyword_id=aggView4540803120596567678.v25);
create or replace view aggJoin86822001131786992 as (
with aggView3529994213298784854 as (select v3 from aggJoin3326409462342390383 group by v3)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView3529994213298784854 where mc.movie_id=aggView3529994213298784854.v3);
create or replace view aggJoin3175936167124145610 as (
with aggView5577617421092263859 as (select id as v20 from company_name as cn)
select v3 from aggJoin86822001131786992 join aggView5577617421092263859 using(v20));
create or replace view aggJoin6390787884511784071 as (
with aggView8458889199414827215 as (select id as v3 from title as t)
select v3 from aggJoin3175936167124145610 join aggView8458889199414827215 using(v3));
create or replace view aggJoin7070787080065165448 as (
with aggView2003375897053099415 as (select v3 from aggJoin6390787884511784071 group by v3)
select v47 as v47 from aggJoin773050753077782571 join aggView2003375897053099415 using(v3));
select MIN(v47) as v47 from aggJoin7070787080065165448;
