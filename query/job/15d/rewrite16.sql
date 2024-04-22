create or replace view aggJoin5335439400967485022 as (
with aggView1227363342278359733 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView1227363342278359733 where mc.company_id=aggView1227363342278359733.v13);
create or replace view aggJoin1188849878545351377 as (
with aggView5295368487049494580 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView5295368487049494580 where mi.info_type_id=aggView5295368487049494580.v22 and note LIKE '%internet%');
create or replace view aggJoin3556814693949752716 as (
with aggView8160494068885522300 as (select v40 from aggJoin1188849878545351377 group by v40)
select v40, v20 from aggJoin5335439400967485022 join aggView8160494068885522300 using(v40));
create or replace view aggJoin6614220490741638080 as (
with aggView8867907646700919132 as (select id as v20 from company_type as ct)
select v40 from aggJoin3556814693949752716 join aggView8867907646700919132 using(v20));
create or replace view aggJoin6174806470453800600 as (
with aggView5060237472933664298 as (select v40 from aggJoin6614220490741638080 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView5060237472933664298 where t.id=aggView5060237472933664298.v40 and production_year>1990);
create or replace view aggJoin372597503489519616 as (
with aggView6651905639373157274 as (select v40, MIN(v41) as v53 from aggJoin6174806470453800600 group by v40)
select movie_id as v40, title as v3, v53 from aka_title as aka_t, aggView6651905639373157274 where aka_t.movie_id=aggView6651905639373157274.v40);
create or replace view aggJoin2582216515826516958 as (
with aggView2277053407468958021 as (select v40, MIN(v53) as v53, MIN(v3) as v52 from aggJoin372597503489519616 group by v40,v53)
select keyword_id as v24, v53, v52 from movie_keyword as mk, aggView2277053407468958021 where mk.movie_id=aggView2277053407468958021.v40);
create or replace view aggJoin1443543408292356977 as (
with aggView1141640347978463394 as (select id as v24 from keyword as k)
select v53, v52 from aggJoin2582216515826516958 join aggView1141640347978463394 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin1443543408292356977;
