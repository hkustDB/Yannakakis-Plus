create or replace view aggJoin1447573383259076765 as (
with aggView3255059247337972279 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView3255059247337972279 where mi.info_type_id=aggView3255059247337972279.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin1213855040279362653 as (
with aggView5817998778869197426 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView5817998778869197426 where mc.company_id=aggView5817998778869197426.v23);
create or replace view aggJoin1503050309883816012 as (
with aggView4827466278378059408 as (select v53 from aggJoin1447573383259076765 group by v53)
select v53 from aggJoin1213855040279362653 join aggView4827466278378059408 using(v53));
create or replace view aggJoin7991410216851394578 as (
with aggView6428916698065743364 as (select v53 from aggJoin1503050309883816012 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView6428916698065743364 where t.id=aggView6428916698065743364.v53 and production_year>2000);
create or replace view aggView4746650762167857542 as select v53, v54 from aggJoin7991410216851394578 group by v53,v54;
create or replace view aggJoin4688527867475572635 as (
with aggView5136748251463682530 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView5136748251463682530 where n.id=aggView5136748251463682530.v42 and name LIKE '%An%' and gender= 'f');
create or replace view aggView8107025385047377293 as select v43, v42 from aggJoin4688527867475572635 group by v43,v42;
create or replace view aggJoin885314555197139113 as (
with aggView6487716892470122472 as (select v53, MIN(v54) as v66 from aggView4746650762167857542 group by v53)
select person_id as v42, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView6487716892470122472 where ci.movie_id=aggView6487716892470122472.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5584405614262433207 as (
with aggView4888548445665861147 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v9, v20, v66 from aggJoin885314555197139113 join aggView4888548445665861147 using(v51));
create or replace view aggJoin2062968957159153433 as (
with aggView6001163860011406791 as (select id as v9 from char_name as chn)
select v42, v20, v66 from aggJoin5584405614262433207 join aggView6001163860011406791 using(v9));
create or replace view aggJoin6673105273405777434 as (
with aggView6835684780582203964 as (select v42, MIN(v66) as v66 from aggJoin2062968957159153433 group by v42,v66)
select v43, v66 from aggView8107025385047377293 join aggView6835684780582203964 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin6673105273405777434;
