create or replace view aggView4886122475392397394 as select id as v42, name as v43 from name as n where gender= 'f';
create or replace view aggJoin6447820775735325435 as (
with aggView5814660463950960261 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView5814660463950960261 where mc.company_id=aggView5814660463950960261.v23);
create or replace view aggJoin1410905454151807537 as (
with aggView2401240556019354562 as (select v53 from aggJoin6447820775735325435 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView2401240556019354562 where t.id=aggView2401240556019354562.v53 and production_year>2000);
create or replace view aggView6452301883800820249 as select v53, v54 from aggJoin1410905454151807537 group by v53,v54;
create or replace view aggJoin5439236593642340601 as (
with aggView7820684499134868951 as (select v42, MIN(v43) as v65 from aggView4886122475392397394 group by v42)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView7820684499134868951 where ci.person_id=aggView7820684499134868951.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1522830894774978364 as (
with aggView8724088673841337622 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v51, v65 as v65 from aggJoin5439236593642340601 join aggView8724088673841337622 using(v42));
create or replace view aggJoin5038458356066166432 as (
with aggView6584488552341650216 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView6584488552341650216 where mi.info_type_id=aggView6584488552341650216.v30);
create or replace view aggJoin4164373475759291849 as (
with aggView6349189438536930417 as (select v53 from aggJoin5038458356066166432 group by v53)
select v53, v9, v20, v51, v65 as v65 from aggJoin1522830894774978364 join aggView6349189438536930417 using(v53));
create or replace view aggJoin4302165200637610503 as (
with aggView4863387150267907496 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65 from aggJoin4164373475759291849 join aggView4863387150267907496 using(v51));
create or replace view aggJoin1807896398825004335 as (
with aggView623783435860491075 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin4302165200637610503 join aggView623783435860491075 using(v9));
create or replace view aggJoin7919879091488355460 as (
with aggView8702994895631899003 as (select v53, MIN(v65) as v65 from aggJoin1807896398825004335 group by v53,v65)
select v54, v65 from aggView6452301883800820249 join aggView8702994895631899003 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin7919879091488355460;
