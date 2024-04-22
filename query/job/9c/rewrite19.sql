create or replace view aggJoin9043265621182482464 as (
with aggView1495705478852907044 as (select id as v9, name as v59 from char_name as chn)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView1495705478852907044 where ci.person_role_id=aggView1495705478852907044.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2343464557238281672 as (
with aggView2109616556929455632 as (select id as v35, name as v60 from name as n where name LIKE '%An%' and gender= 'f')
select v35, v18, v20, v22, v59, v60 from aggJoin9043265621182482464 join aggView2109616556929455632 using(v35));
create or replace view aggJoin8263457461709576155 as (
with aggView1408083266181772040 as (select person_id as v35, MIN(name) as v58 from aka_name as an group by person_id)
select v18, v20, v22, v59 as v59, v60 as v60, v58 from aggJoin2343464557238281672 join aggView1408083266181772040 using(v35));
create or replace view aggJoin9017733819510087473 as (
with aggView1295986035651898338 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v59, v60, v58 from aggJoin8263457461709576155 join aggView1295986035651898338 using(v22));
create or replace view aggJoin5274185898510511645 as (
with aggView4526263411051341840 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView4526263411051341840 where mc.company_id=aggView4526263411051341840.v32);
create or replace view aggJoin8613858302188371169 as (
with aggView1493565183235115247 as (select v18, MIN(v59) as v59, MIN(v60) as v60, MIN(v58) as v58 from aggJoin9017733819510087473 group by v18,v58,v60,v59)
select v18, v59, v60, v58 from aggJoin5274185898510511645 join aggView1493565183235115247 using(v18));
create or replace view aggJoin352328413431874091 as (
with aggView4051072862075909850 as (select v18, MIN(v59) as v59, MIN(v60) as v60, MIN(v58) as v58 from aggJoin8613858302188371169 group by v18,v58,v60,v59)
select title as v47, v59, v60, v58 from title as t, aggView4051072862075909850 where t.id=aggView4051072862075909850.v18);
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin352328413431874091;
