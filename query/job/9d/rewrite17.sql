create or replace view aggJoin6619140360960002103 as (
with aggView8002591284272401124 as (select person_id as v35, MIN(name) as v58 from aka_name as an group by person_id)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v58 from cast_info as ci, aggView8002591284272401124 where ci.person_id=aggView8002591284272401124.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2648542820206301312 as (
with aggView2653286986551318526 as (select id as v9, name as v59 from char_name as chn)
select v35, v18, v20, v22, v58, v59 from aggJoin6619140360960002103 join aggView2653286986551318526 using(v9));
create or replace view aggJoin481404875108992263 as (
with aggView6112260714622984736 as (select id as v35, name as v60 from name as n where gender= 'f')
select v18, v20, v22, v58, v59, v60 from aggJoin2648542820206301312 join aggView6112260714622984736 using(v35));
create or replace view aggJoin2087076660786333999 as (
with aggView3987464028241806303 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v58, v59, v60 from aggJoin481404875108992263 join aggView3987464028241806303 using(v22));
create or replace view aggJoin8042518389637938556 as (
with aggView1902496050889396494 as (select v18, MIN(v58) as v58, MIN(v59) as v59, MIN(v60) as v60 from aggJoin2087076660786333999 group by v18,v60,v59,v58)
select id as v18, title as v47, v58, v59, v60 from title as t, aggView1902496050889396494 where t.id=aggView1902496050889396494.v18);
create or replace view aggJoin324049002335476997 as (
with aggView8264834756865222532 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView8264834756865222532 where mc.company_id=aggView8264834756865222532.v32);
create or replace view aggJoin1521636146724518356 as (
with aggView8386518183939098029 as (select v18 from aggJoin324049002335476997 group by v18)
select v47, v58 as v58, v59 as v59, v60 as v60 from aggJoin8042518389637938556 join aggView8386518183939098029 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin1521636146724518356;
