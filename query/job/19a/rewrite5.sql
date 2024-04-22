create or replace view aggJoin901335534933071081 as (
with aggView5834104879315534054 as (select id as v42, name as v65 from name as n where name LIKE '%Ang%' and gender= 'f')
select person_id as v42, v65 from aka_name as an, aggView5834104879315534054 where an.person_id=aggView5834104879315534054.v42);
create or replace view aggJoin2280890885585245733 as (
with aggView3531340243963248434 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView3531340243963248434 where mc.company_id=aggView3531340243963248434.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin3050394983259736132 as (
with aggView8664988564104790452 as (select v53 from aggJoin2280890885585245733 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView8664988564104790452 where t.id=aggView8664988564104790452.v53 and production_year>=2005 and production_year<=2009);
create or replace view aggJoin4999161117364886865 as (
with aggView7561672979554938008 as (select v53, MIN(v54) as v66 from aggJoin3050394983259736132 group by v53)
select movie_id as v53, info_type_id as v30, info as v40, v66 from movie_info as mi, aggView7561672979554938008 where mi.movie_id=aggView7561672979554938008.v53 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin4193919582899352702 as (
with aggView2682444927703143225 as (select v42, MIN(v65) as v65 from aggJoin901335534933071081 group by v42,v65)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView2682444927703143225 where ci.person_id=aggView2682444927703143225.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6334663634131303625 as (
with aggView1374432638797780865 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40, v66 from aggJoin4999161117364886865 join aggView1374432638797780865 using(v30));
create or replace view aggJoin1207671301456811877 as (
with aggView2476963762458309442 as (select v53, MIN(v66) as v66 from aggJoin6334663634131303625 group by v53,v66)
select v9, v20, v51, v65 as v65, v66 from aggJoin4193919582899352702 join aggView2476963762458309442 using(v53));
create or replace view aggJoin4248796679165639193 as (
with aggView5127809629095092408 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin1207671301456811877 join aggView5127809629095092408 using(v51));
create or replace view aggJoin6468519384761430923 as (
with aggView2987932445076535463 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin4248796679165639193 group by v9,v66,v65)
select v65, v66 from char_name as chn, aggView2987932445076535463 where chn.id=aggView2987932445076535463.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin6468519384761430923;
