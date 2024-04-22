create or replace view aggJoin1617527808168931935 as (
with aggView3171501924262395690 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView3171501924262395690 where t.kind_id=aggView3171501924262395690.v21 and production_year>2000);
create or replace view aggJoin7033358380635923928 as (
with aggView1529506847957921537 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView1529506847957921537 where mi.info_type_id=aggView1529506847957921537.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin8017129139002376404 as (
with aggView8045015484738782536 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView8045015484738782536 where mc.company_type_id=aggView8045015484738782536.v14);
create or replace view aggJoin8417022355458557201 as (
with aggView2353855031603192484 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView2353855031603192484 where mk.keyword_id=aggView2353855031603192484.v18);
create or replace view aggJoin2038040086481488946 as (
with aggView5533186783863161350 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView5533186783863161350 where cc.status_id=aggView5533186783863161350.v5);
create or replace view aggJoin263320053340644581 as (
with aggView1663368283740940259 as (select v36 from aggJoin2038040086481488946 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin1617527808168931935 join aggView1663368283740940259 using(v36));
create or replace view aggJoin4636756771724283952 as (
with aggView4810625920856799708 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin263320053340644581 group by v36,v48)
select v36, v31, v32, v48, v49 from aggJoin7033358380635923928 join aggView4810625920856799708 using(v36));
create or replace view aggJoin553504274796465184 as (
with aggView4907192904430553293 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin4636756771724283952 group by v36,v48,v49)
select v36, v48, v49 from aggJoin8417022355458557201 join aggView4907192904430553293 using(v36));
create or replace view aggJoin6357979745239067135 as (
with aggView5744960989560285181 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin8017129139002376404 join aggView5744960989560285181 using(v7));
create or replace view aggJoin2409838216608787900 as (
with aggView1684150224452421841 as (select v36 from aggJoin6357979745239067135 group by v36)
select v48 as v48, v49 as v49 from aggJoin553504274796465184 join aggView1684150224452421841 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin2409838216608787900;
