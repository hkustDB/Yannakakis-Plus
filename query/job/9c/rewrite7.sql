create or replace view aggJoin7858043886252362823 as (
with aggView7069495012249345961 as (select id as v9, name as v59 from char_name as chn)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView7069495012249345961 where ci.person_role_id=aggView7069495012249345961.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1362862108238173667 as (
with aggView3250767631919667893 as (select id as v35, name as v60 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v35, name as v3, v60 from aka_name as an, aggView3250767631919667893 where an.person_id=aggView3250767631919667893.v35);
create or replace view aggJoin2240410399011768139 as (
with aggView1360072840053324104 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin1362862108238173667 group by v35,v60)
select v18, v20, v22, v59 as v59, v60, v58 from aggJoin7858043886252362823 join aggView1360072840053324104 using(v35));
create or replace view aggJoin2085587583642654796 as (
with aggView8321685564224247042 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v59, v60, v58 from aggJoin2240410399011768139 join aggView8321685564224247042 using(v22));
create or replace view aggJoin4628068085582612731 as (
with aggView6191869777631959168 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView6191869777631959168 where mc.company_id=aggView6191869777631959168.v32);
create or replace view aggJoin2118590008640362944 as (
with aggView7251293039182274901 as (select v18, MIN(v59) as v59, MIN(v60) as v60, MIN(v58) as v58 from aggJoin2085587583642654796 group by v18,v58,v60,v59)
select v18, v59, v60, v58 from aggJoin4628068085582612731 join aggView7251293039182274901 using(v18));
create or replace view aggJoin3224403592507188157 as (
with aggView2911698163431197551 as (select v18, MIN(v59) as v59, MIN(v60) as v60, MIN(v58) as v58 from aggJoin2118590008640362944 group by v18,v58,v60,v59)
select title as v47, v59, v60, v58 from title as t, aggView2911698163431197551 where t.id=aggView2911698163431197551.v18);
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin3224403592507188157;
