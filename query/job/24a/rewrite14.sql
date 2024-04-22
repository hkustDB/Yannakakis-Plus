create or replace view aggView4033519175137056852 as select id as v48, name as v49 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggView525669110027209534 as select id as v59, title as v60 from title as t where production_year>2010;
create or replace view aggView6203355074966563427 as select name as v10, id as v9 from char_name as chn;
create or replace view aggJoin3902535179941535915 as (
with aggView8678997952576207040 as (select v48, MIN(v49) as v72 from aggView4033519175137056852 group by v48)
select person_id as v48, movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v72 from cast_info as ci, aggView8678997952576207040 where ci.person_id=aggView8678997952576207040.v48 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin7839056864760366460 as (
with aggView7279326370589737589 as (select v59, MIN(v60) as v73 from aggView525669110027209534 group by v59)
select v48, v59, v9, v20, v57, v72 as v72, v73 from aggJoin3902535179941535915 join aggView7279326370589737589 using(v59));
create or replace view aggJoin3909347338280564142 as (
with aggView6797755351578292376 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView6797755351578292376 where mi.info_type_id=aggView6797755351578292376.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin7234278970962088538 as (
with aggView7511183453036518258 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView7511183453036518258 where mc.company_id=aggView7511183453036518258.v23);
create or replace view aggJoin8367306101009100691 as (
with aggView6627680592790977870 as (select person_id as v48 from aka_name as an group by person_id)
select v59, v9, v20, v57, v72 as v72, v73 as v73 from aggJoin7839056864760366460 join aggView6627680592790977870 using(v48));
create or replace view aggJoin24651257223156994 as (
with aggView7866851119151021447 as (select v59 from aggJoin3909347338280564142 group by v59)
select v59 from aggJoin7234278970962088538 join aggView7866851119151021447 using(v59));
create or replace view aggJoin8344640435246264380 as (
with aggView1529058128273289607 as (select v59 from aggJoin24651257223156994 group by v59)
select movie_id as v59, keyword_id as v32 from movie_keyword as mk, aggView1529058128273289607 where mk.movie_id=aggView1529058128273289607.v59);
create or replace view aggJoin2722725969996007144 as (
with aggView7751231635716248400 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v9, v20, v72, v73 from aggJoin8367306101009100691 join aggView7751231635716248400 using(v57));
create or replace view aggJoin5450894560701406549 as (
with aggView9059238549208281165 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select v59 from aggJoin8344640435246264380 join aggView9059238549208281165 using(v32));
create or replace view aggJoin6734050260832843909 as (
with aggView1619025657596479818 as (select v59 from aggJoin5450894560701406549 group by v59)
select v9, v20, v72 as v72, v73 as v73 from aggJoin2722725969996007144 join aggView1619025657596479818 using(v59));
create or replace view aggJoin1140240866802470662 as (
with aggView3082301176094222272 as (select v9, MIN(v72) as v72, MIN(v73) as v73 from aggJoin6734050260832843909 group by v9,v73,v72)
select v10, v72, v73 from aggView6203355074966563427 join aggView3082301176094222272 using(v9));
select MIN(v10) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin1140240866802470662;
