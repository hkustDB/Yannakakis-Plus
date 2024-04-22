create or replace view aggJoin2609704236781621828 as (
with aggView749424699782947653 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView749424699782947653 where t.kind_id=aggView749424699782947653.v21 and production_year>2000);
create or replace view aggJoin1897029577576844488 as (
with aggView2316582277509591793 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView2316582277509591793 where mc.company_type_id=aggView2316582277509591793.v14);
create or replace view aggJoin4754238712772023849 as (
with aggView3660348467574822112 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView3660348467574822112 where mk.keyword_id=aggView3660348467574822112.v18);
create or replace view aggJoin4491598906482767280 as (
with aggView6141186755248532 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView6141186755248532 where mi.info_type_id=aggView6141186755248532.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin1601327634503040575 as (
with aggView4670979706706451385 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView4670979706706451385 where cc.status_id=aggView4670979706706451385.v5);
create or replace view aggJoin6589750652454518764 as (
with aggView8495885057776207437 as (select v36 from aggJoin1601327634503040575 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin2609704236781621828 join aggView8495885057776207437 using(v36));
create or replace view aggJoin4880565183689060524 as (
with aggView1918923639214034789 as (select v36 from aggJoin4491598906482767280 group by v36)
select v36 from aggJoin4754238712772023849 join aggView1918923639214034789 using(v36));
create or replace view aggJoin6002829144988503296 as (
with aggView147723496111776030 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin1897029577576844488 join aggView147723496111776030 using(v7));
create or replace view aggJoin5349576479269300562 as (
with aggView1019746744247727489 as (select v36 from aggJoin6002829144988503296 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin6589750652454518764 join aggView1019746744247727489 using(v36));
create or replace view aggJoin5214232384471764056 as (
with aggView4877847924190650505 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin5349576479269300562 group by v36,v48)
select v48, v49 from aggJoin4880565183689060524 join aggView4877847924190650505 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin5214232384471764056;
