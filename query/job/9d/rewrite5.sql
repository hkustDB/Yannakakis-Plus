create or replace view aggJoin9007140616264423283 as (
with aggView981622115427740695 as (select person_id as v35, MIN(name) as v58 from aka_name as an group by person_id)
select id as v35, name as v36, gender as v39, v58 from name as n, aggView981622115427740695 where n.id=aggView981622115427740695.v35 and gender= 'f');
create or replace view aggJoin4729796437514632363 as (
with aggView3125926940755495505 as (select id as v9, name as v59 from char_name as chn)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView3125926940755495505 where ci.person_role_id=aggView3125926940755495505.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2140890115697413870 as (
with aggView5145300190909501361 as (select v35, MIN(v58) as v58, MIN(v36) as v60 from aggJoin9007140616264423283 group by v35,v58)
select v18, v20, v22, v59 as v59, v58, v60 from aggJoin4729796437514632363 join aggView5145300190909501361 using(v35));
create or replace view aggJoin2003431399901451150 as (
with aggView5644793398382897559 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v59, v58, v60 from aggJoin2140890115697413870 join aggView5644793398382897559 using(v22));
create or replace view aggJoin9010106623709901676 as (
with aggView4765607140872981641 as (select v18, MIN(v59) as v59, MIN(v58) as v58, MIN(v60) as v60 from aggJoin2003431399901451150 group by v18,v60,v59,v58)
select movie_id as v18, company_id as v32, v59, v58, v60 from movie_companies as mc, aggView4765607140872981641 where mc.movie_id=aggView4765607140872981641.v18);
create or replace view aggJoin6212844947739700148 as (
with aggView4514516956978823664 as (select id as v32 from company_name as cn where country_code= '[us]')
select v18, v59, v58, v60 from aggJoin9010106623709901676 join aggView4514516956978823664 using(v32));
create or replace view aggJoin8474883245700353887 as (
with aggView5390333172726681068 as (select v18, MIN(v59) as v59, MIN(v58) as v58, MIN(v60) as v60 from aggJoin6212844947739700148 group by v18,v60,v59,v58)
select title as v47, v59, v58, v60 from title as t, aggView5390333172726681068 where t.id=aggView5390333172726681068.v18);
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin8474883245700353887;
