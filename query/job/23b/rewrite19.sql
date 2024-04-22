create or replace view aggJoin5838424814004336495 as (
with aggView942024348181281441 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView942024348181281441 where mc.company_type_id=aggView942024348181281441.v14);
create or replace view aggJoin2269101200632891034 as (
with aggView8003176555079845584 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView8003176555079845584 where mk.keyword_id=aggView8003176555079845584.v18);
create or replace view aggJoin5559594862152525059 as (
with aggView442069366511382316 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView442069366511382316 where mi.info_type_id=aggView442069366511382316.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin8703188623748956481 as (
with aggView4656844258637124791 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView4656844258637124791 where cc.status_id=aggView4656844258637124791.v5);
create or replace view aggJoin4555795026258228789 as (
with aggView5682615714575908799 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin5838424814004336495 join aggView5682615714575908799 using(v7));
create or replace view aggJoin2082775921566247954 as (
with aggView114330591043968402 as (select v36 from aggJoin2269101200632891034 group by v36)
select v36 from aggJoin4555795026258228789 join aggView114330591043968402 using(v36));
create or replace view aggJoin578583519733220645 as (
with aggView6727586301367352275 as (select v36 from aggJoin5559594862152525059 group by v36)
select v36 from aggJoin2082775921566247954 join aggView6727586301367352275 using(v36));
create or replace view aggJoin6414213535136377099 as (
with aggView518380143013806604 as (select v36 from aggJoin8703188623748956481 group by v36)
select v36 from aggJoin578583519733220645 join aggView518380143013806604 using(v36));
create or replace view aggJoin6418872248469564744 as (
with aggView4618946931191041221 as (select v36 from aggJoin6414213535136377099 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView4618946931191041221 where t.id=aggView4618946931191041221.v36 and production_year>2000);
create or replace view aggView5622913136596253351 as select v37, v21 from aggJoin6418872248469564744 group by v37,v21;
create or replace view aggJoin6854770908151375471 as (
with aggView7431279518445025977 as (select v21, MIN(v37) as v49 from aggView5622913136596253351 group by v21)
select kind as v22, v49 from kind_type as kt, aggView7431279518445025977 where kt.id=aggView7431279518445025977.v21 and kind= 'movie');
select MIN(v22) as v48,MIN(v49) as v49 from aggJoin6854770908151375471;
