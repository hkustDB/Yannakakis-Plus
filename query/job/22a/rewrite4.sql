create or replace view aggView7003879046923834582 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin8831290047307594005 as (
with aggView575574777289157494 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView575574777289157494 where mi_idx.info_type_id=aggView575574777289157494.v12 and info<'7.0');
create or replace view aggJoin7407863115287669471 as (
with aggView4493136572084133910 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView4493136572084133910 where t.kind_id=aggView4493136572084133910.v17 and production_year>2008);
create or replace view aggView8833056158864357480 as select v38, v37 from aggJoin7407863115287669471 group by v38,v37;
create or replace view aggJoin580137791350360491 as (
with aggView6385921308622943574 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView6385921308622943574 where mi.info_type_id=aggView6385921308622943574.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin1718351805379593382 as (
with aggView3448211728995356779 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView3448211728995356779 where mk.keyword_id=aggView3448211728995356779.v14);
create or replace view aggJoin8023605311995117663 as (
with aggView6285793320056633151 as (select v37 from aggJoin1718351805379593382 group by v37)
select v37, v27 from aggJoin580137791350360491 join aggView6285793320056633151 using(v37));
create or replace view aggJoin8604298803577622819 as (
with aggView1717381476029876116 as (select v37 from aggJoin8023605311995117663 group by v37)
select v37, v32 from aggJoin8831290047307594005 join aggView1717381476029876116 using(v37));
create or replace view aggView2489389709753596092 as select v32, v37 from aggJoin8604298803577622819 group by v32,v37;
create or replace view aggJoin1592008607355636688 as (
with aggView2693741472044370964 as (select v1, MIN(v2) as v49 from aggView7003879046923834582 group by v1)
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView2693741472044370964 where mc.company_id=aggView2693741472044370964.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3430360572208853311 as (
with aggView8234706008636098541 as (select v37, MIN(v32) as v50 from aggView2489389709753596092 group by v37)
select v37, v8, v23, v49 as v49, v50 from aggJoin1592008607355636688 join aggView8234706008636098541 using(v37));
create or replace view aggJoin6375355054952483759 as (
with aggView3333472162335425111 as (select id as v8 from company_type as ct)
select v37, v23, v49, v50 from aggJoin3430360572208853311 join aggView3333472162335425111 using(v8));
create or replace view aggJoin511464586395516077 as (
with aggView1860086877626801980 as (select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin6375355054952483759 group by v37,v49,v50)
select v38, v49, v50 from aggView8833056158864357480 join aggView1860086877626801980 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v38) as v51 from aggJoin511464586395516077;
