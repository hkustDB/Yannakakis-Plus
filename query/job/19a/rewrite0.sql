create or replace view aggJoin8012251361438765106 as (
with aggView6417227428313939958 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView6417227428313939958 where n.id=aggView6417227428313939958.v42 and name LIKE '%Ang%' and gender= 'f');
create or replace view aggView3741736348908334281 as select v42, v43 from aggJoin8012251361438765106 group by v42,v43;
create or replace view aggJoin4530326655152917322 as (
with aggView2152536621332809997 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView2152536621332809997 where mc.company_id=aggView2152536621332809997.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin5289505431104305729 as (
with aggView1233296069132488650 as (select v53 from aggJoin4530326655152917322 group by v53)
select movie_id as v53, info_type_id as v30, info as v40 from movie_info as mi, aggView1233296069132488650 where mi.movie_id=aggView1233296069132488650.v53 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin7444594398274896050 as (
with aggView2054922548648914272 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40 from aggJoin5289505431104305729 join aggView2054922548648914272 using(v30));
create or replace view aggJoin6682378024969082651 as (
with aggView5676692973265572823 as (select v53 from aggJoin7444594398274896050 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView5676692973265572823 where t.id=aggView5676692973265572823.v53 and production_year>=2005 and production_year<=2009);
create or replace view aggView5040624120524435145 as select v53, v54 from aggJoin6682378024969082651 group by v53,v54;
create or replace view aggJoin383624153075251003 as (
with aggView773349092444167402 as (select v53, MIN(v54) as v66 from aggView5040624120524435145 group by v53)
select person_id as v42, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView773349092444167402 where ci.movie_id=aggView773349092444167402.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin7929375943886045011 as (
with aggView8618447191213980425 as (select id as v9 from char_name as chn)
select v42, v20, v51, v66 from aggJoin383624153075251003 join aggView8618447191213980425 using(v9));
create or replace view aggJoin1301163039227439219 as (
with aggView9046009204826508892 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v20, v66 from aggJoin7929375943886045011 join aggView9046009204826508892 using(v51));
create or replace view aggJoin1628623065421433142 as (
with aggView7850226606301477918 as (select v42, MIN(v66) as v66 from aggJoin1301163039227439219 group by v42,v66)
select v43, v66 from aggView3741736348908334281 join aggView7850226606301477918 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin1628623065421433142;
