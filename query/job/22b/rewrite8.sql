create or replace view aggJoin4421780338544618960 as (
with aggView7050653113704745668 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView7050653113704745668 where mc.company_id=aggView7050653113704745668.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4353261500733624676 as (
with aggView6613815727026299230 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView6613815727026299230 where mi_idx.info_type_id=aggView6613815727026299230.v12 and info<'7.0');
create or replace view aggJoin596070172536192715 as (
with aggView4950515760538806005 as (select v37, MIN(v32) as v50 from aggJoin4353261500733624676 group by v37)
select id as v37, title as v38, kind_id as v17, production_year as v41, v50 from title as t, aggView4950515760538806005 where t.id=aggView4950515760538806005.v37 and production_year>2009);
create or replace view aggJoin6600673414066558714 as (
with aggView1398908791577589460 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41, v50 from aggJoin596070172536192715 join aggView1398908791577589460 using(v17));
create or replace view aggJoin8189282716067329164 as (
with aggView1456215310553109701 as (select v37, MIN(v50) as v50, MIN(v38) as v51 from aggJoin6600673414066558714 group by v37,v50)
select movie_id as v37, info_type_id as v10, info as v27, v50, v51 from movie_info as mi, aggView1456215310553109701 where mi.movie_id=aggView1456215310553109701.v37 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin3331483896878598478 as (
with aggView6592257276915056346 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin4421780338544618960 join aggView6592257276915056346 using(v8));
create or replace view aggJoin4600971037419935252 as (
with aggView3236926645708024962 as (select id as v10 from info_type as it1 where info= 'countries')
select v37, v27, v50, v51 from aggJoin8189282716067329164 join aggView3236926645708024962 using(v10));
create or replace view aggJoin8759773789246519959 as (
with aggView4625588026854668872 as (select v37, MIN(v50) as v50, MIN(v51) as v51 from aggJoin4600971037419935252 group by v37,v50,v51)
select v37, v23, v49 as v49, v50, v51 from aggJoin3331483896878598478 join aggView4625588026854668872 using(v37));
create or replace view aggJoin5098405018697814806 as (
with aggView2747207807341172382 as (select v37, MIN(v49) as v49, MIN(v50) as v50, MIN(v51) as v51 from aggJoin8759773789246519959 group by v37,v49,v50,v51)
select keyword_id as v14, v49, v50, v51 from movie_keyword as mk, aggView2747207807341172382 where mk.movie_id=aggView2747207807341172382.v37);
create or replace view aggJoin1200613680703232672 as (
with aggView3939033425797922588 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v50, v51 from aggJoin5098405018697814806 join aggView3939033425797922588 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin1200613680703232672;
