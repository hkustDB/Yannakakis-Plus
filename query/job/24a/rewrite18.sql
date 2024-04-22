create or replace view aggJoin8197673573892036141 as (
with aggView6965658440084561453 as (select id as v59, title as v73 from title as t where production_year>2010)
select person_id as v48, movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v73 from cast_info as ci, aggView6965658440084561453 where ci.movie_id=aggView6965658440084561453.v59 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin7050288877982633880 as (
with aggView6170090555202846268 as (select id as v9, name as v71 from char_name as chn)
select v48, v59, v20, v57, v73, v71 from aggJoin8197673573892036141 join aggView6170090555202846268 using(v9));
create or replace view aggJoin5259712320136087485 as (
with aggView5376483784009688901 as (select id as v48, name as v72 from name as n where name LIKE '%An%' and gender= 'f')
select v48, v59, v20, v57, v73, v71, v72 from aggJoin7050288877982633880 join aggView5376483784009688901 using(v48));
create or replace view aggJoin7391662750416109580 as (
with aggView4602882577734546615 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView4602882577734546615 where mi.info_type_id=aggView4602882577734546615.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin8785462829850422107 as (
with aggView4487883015539749061 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView4487883015539749061 where mc.company_id=aggView4487883015539749061.v23);
create or replace view aggJoin792788061230074217 as (
with aggView2370441129838411212 as (select person_id as v48 from aka_name as an group by person_id)
select v59, v20, v57, v73 as v73, v71 as v71, v72 as v72 from aggJoin5259712320136087485 join aggView2370441129838411212 using(v48));
create or replace view aggJoin761377245364601980 as (
with aggView3334126538437024411 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v20, v73, v71, v72 from aggJoin792788061230074217 join aggView3334126538437024411 using(v57));
create or replace view aggJoin8427230448093623829 as (
with aggView2489874876073745299 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView2489874876073745299 where mk.keyword_id=aggView2489874876073745299.v32);
create or replace view aggJoin8746520868247411697 as (
with aggView900718569648520896 as (select v59 from aggJoin8427230448093623829 group by v59)
select v59 from aggJoin8785462829850422107 join aggView900718569648520896 using(v59));
create or replace view aggJoin1839260898252374672 as (
with aggView680136343703431225 as (select v59 from aggJoin8746520868247411697 group by v59)
select v59, v20, v73 as v73, v71 as v71, v72 as v72 from aggJoin761377245364601980 join aggView680136343703431225 using(v59));
create or replace view aggJoin1190704534500474255 as (
with aggView2364839317532173647 as (select v59, MIN(v73) as v73, MIN(v71) as v71, MIN(v72) as v72 from aggJoin1839260898252374672 group by v59,v73,v72,v71)
select v73, v71, v72 from aggJoin7391662750416109580 join aggView2364839317532173647 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin1190704534500474255;
