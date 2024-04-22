create or replace view aggJoin3815921958900138560 as (
with aggView8003906226493815168 as (select id as v35, name as v60 from name as n where gender= 'f')
select person_id as v35, name as v3, v60 from aka_name as an, aggView8003906226493815168 where an.person_id=aggView8003906226493815168.v35);
create or replace view aggJoin1691505308507739222 as (
with aggView498581058131641484 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin3815921958900138560 group by v35,v60)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60, v58 from cast_info as ci, aggView498581058131641484 where ci.person_id=aggView498581058131641484.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6580144877572904145 as (
with aggView772464525065631474 as (select id as v9, name as v59 from char_name as chn)
select v18, v20, v22, v60, v58, v59 from aggJoin1691505308507739222 join aggView772464525065631474 using(v9));
create or replace view aggJoin7193506544825609336 as (
with aggView2365342041450552480 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v60, v58, v59 from aggJoin6580144877572904145 join aggView2365342041450552480 using(v22));
create or replace view aggJoin405203354490218540 as (
with aggView1864929174695956485 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView1864929174695956485 where mc.company_id=aggView1864929174695956485.v32);
create or replace view aggJoin8713300414151351260 as (
with aggView491972130860601595 as (select v18 from aggJoin405203354490218540 group by v18)
select v18, v20, v60 as v60, v58 as v58, v59 as v59 from aggJoin7193506544825609336 join aggView491972130860601595 using(v18));
create or replace view aggJoin2522993347870080473 as (
with aggView5076797456874900969 as (select v18, MIN(v60) as v60, MIN(v58) as v58, MIN(v59) as v59 from aggJoin8713300414151351260 group by v18,v60,v59,v58)
select title as v47, v60, v58, v59 from title as t, aggView5076797456874900969 where t.id=aggView5076797456874900969.v18);
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin2522993347870080473;
