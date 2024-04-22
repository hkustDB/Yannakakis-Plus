create or replace view aggJoin1834751386113166694 as (
with aggView5870715819021724082 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView5870715819021724082 where t.kind_id=aggView5870715819021724082.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin1719826957177091921 as (
with aggView662094227568534639 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select movie_id as v23 from movie_keyword as mk, aggView662094227568534639 where mk.keyword_id=aggView662094227568534639.v5);
create or replace view aggJoin2946605596865222394 as (
with aggView8103821319112795432 as (select v23 from aggJoin1719826957177091921 group by v23)
select v23, v24, v27 from aggJoin1834751386113166694 join aggView8103821319112795432 using(v23));
create or replace view aggView1437127534104060484 as select v23, v24 from aggJoin2946605596865222394 group by v23,v24;
create or replace view aggJoin3935401517001074551 as (
with aggView6121415977270086452 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView6121415977270086452 where mi_idx.info_type_id=aggView6121415977270086452.v3);
create or replace view aggJoin8154162492250862992 as (
with aggView8477288488253767831 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView8477288488253767831 where mi.info_type_id=aggView8477288488253767831.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin1166065334758853075 as (
with aggView4390617628455014109 as (select v23 from aggJoin8154162492250862992 group by v23)
select v23, v18 from aggJoin3935401517001074551 join aggView4390617628455014109 using(v23));
create or replace view aggJoin4509633204149996623 as (
with aggView1037248694322593118 as (select v23, v18 from aggJoin1166065334758853075 group by v23,v18)
select v23, v18 from aggView1037248694322593118 where v18>'6.0');
create or replace view aggJoin8218110725847677451 as (
with aggView8180920790281329184 as (select v23, MIN(v24) as v36 from aggView1437127534104060484 group by v23)
select v18, v36 from aggJoin4509633204149996623 join aggView8180920790281329184 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin8218110725847677451;
