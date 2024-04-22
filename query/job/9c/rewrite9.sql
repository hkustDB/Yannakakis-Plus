create or replace view aggJoin8475665225625460613 as (
with aggView6257776115341837905 as (select id as v9, name as v59 from char_name as chn)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView6257776115341837905 where ci.person_role_id=aggView6257776115341837905.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6740780391598221567 as (
with aggView845381309376561073 as (select person_id as v35, MIN(name) as v58 from aka_name as an group by person_id)
select id as v35, name as v36, gender as v39, v58 from name as n, aggView845381309376561073 where n.id=aggView845381309376561073.v35 and name LIKE '%An%' and gender= 'f');
create or replace view aggJoin1670873458640061032 as (
with aggView2156594651143768098 as (select v35, MIN(v58) as v58, MIN(v36) as v60 from aggJoin6740780391598221567 group by v35,v58)
select v18, v20, v22, v59 as v59, v58, v60 from aggJoin8475665225625460613 join aggView2156594651143768098 using(v35));
create or replace view aggJoin2335233242893086288 as (
with aggView3859221316727637047 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v59, v58, v60 from aggJoin1670873458640061032 join aggView3859221316727637047 using(v22));
create or replace view aggJoin2639649316582117039 as (
with aggView474597714761287999 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView474597714761287999 where mc.company_id=aggView474597714761287999.v32);
create or replace view aggJoin714267189056472913 as (
with aggView5196666890844057033 as (select v18, MIN(v59) as v59, MIN(v58) as v58, MIN(v60) as v60 from aggJoin2335233242893086288 group by v18,v58,v60,v59)
select id as v18, title as v47, v59, v58, v60 from title as t, aggView5196666890844057033 where t.id=aggView5196666890844057033.v18);
create or replace view aggJoin2969303770438650308 as (
with aggView4457646766693656265 as (select v18, MIN(v59) as v59, MIN(v58) as v58, MIN(v60) as v60, MIN(v47) as v61 from aggJoin714267189056472913 group by v18,v58,v60,v59)
select v59, v58, v60, v61 from aggJoin2639649316582117039 join aggView4457646766693656265 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin2969303770438650308;
