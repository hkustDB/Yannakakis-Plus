create or replace view aggView3956643964227543622 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin8676956476665716891 as (
with aggView4296786275873186725 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView4296786275873186725 where mi.info_type_id=aggView4296786275873186725.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin2256839983579324731 as (
with aggView1359552116312870362 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView1359552116312870362 where mk.keyword_id=aggView1359552116312870362.v32);
create or replace view aggJoin1974534642301272804 as (
with aggView597175663728136003 as (select v59 from aggJoin2256839983579324731 group by v59)
select v59, v43 from aggJoin8676956476665716891 join aggView597175663728136003 using(v59));
create or replace view aggJoin1979195245827370606 as (
with aggView1412788028602873938 as (select person_id as v48 from aka_name as an group by person_id)
select id as v48, name as v49, gender as v52 from name as n, aggView1412788028602873938 where n.id=aggView1412788028602873938.v48 and gender= 'f');
create or replace view aggJoin2481688550399355580 as (
with aggView8110436551140986058 as (select v49, v48 from aggJoin1979195245827370606 group by v49,v48)
select v48, v49 from aggView8110436551140986058 where v49 LIKE '%An%');
create or replace view aggJoin6829532634556584201 as (
with aggView2381712344422777806 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select movie_id as v59 from movie_companies as mc, aggView2381712344422777806 where mc.company_id=aggView2381712344422777806.v23);
create or replace view aggJoin5264741486048399055 as (
with aggView7717305140402270930 as (select v59 from aggJoin6829532634556584201 group by v59)
select v59, v43 from aggJoin1974534642301272804 join aggView7717305140402270930 using(v59));
create or replace view aggJoin6606709816004591555 as (
with aggView2750556814223383845 as (select v59 from aggJoin5264741486048399055 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView2750556814223383845 where t.id=aggView2750556814223383845.v59 and production_year>2010);
create or replace view aggJoin4787016499250623982 as (
with aggView4209959123035065195 as (select v59, v60 from aggJoin6606709816004591555 group by v59,v60)
select v59, v60 from aggView4209959123035065195 where v60 LIKE 'Kung Fu Panda%');
create or replace view aggJoin1173727095581558 as (
with aggView4789481990528343467 as (select v48, MIN(v49) as v72 from aggJoin2481688550399355580 group by v48)
select movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v72 from cast_info as ci, aggView4789481990528343467 where ci.person_id=aggView4789481990528343467.v48 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2848762749210587670 as (
with aggView5724506266447069764 as (select v59, MIN(v60) as v73 from aggJoin4787016499250623982 group by v59)
select v9, v20, v57, v72 as v72, v73 from aggJoin1173727095581558 join aggView5724506266447069764 using(v59));
create or replace view aggJoin7261409969803548063 as (
with aggView261064824317649672 as (select id as v57 from role_type as rt where role= 'actress')
select v9, v20, v72, v73 from aggJoin2848762749210587670 join aggView261064824317649672 using(v57));
create or replace view aggJoin4398358920652808633 as (
with aggView1276028184599543123 as (select v9, MIN(v72) as v72, MIN(v73) as v73 from aggJoin7261409969803548063 group by v9,v72,v73)
select v10, v72, v73 from aggView3956643964227543622 join aggView1276028184599543123 using(v9));
select MIN(v10) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin4398358920652808633;
