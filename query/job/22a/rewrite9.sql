create or replace view aggJoin4546375391170463538 as (
with aggView7466009818615748759 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView7466009818615748759 where mc.company_id=aggView7466009818615748759.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1911535712436165474 as (
with aggView3244142241279057559 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin4546375391170463538 join aggView3244142241279057559 using(v8));
create or replace view aggJoin5514678341754394740 as (
with aggView3381993276026928907 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView3381993276026928907 where mi_idx.info_type_id=aggView3381993276026928907.v12 and info<'7.0');
create or replace view aggJoin5425613047160957498 as (
with aggView8600253421092046663 as (select v37, MIN(v32) as v50 from aggJoin5514678341754394740 group by v37)
select movie_id as v37, info_type_id as v10, info as v27, v50 from movie_info as mi, aggView8600253421092046663 where mi.movie_id=aggView8600253421092046663.v37 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin8269405123077759594 as (
with aggView6010232676976619217 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView6010232676976619217 where t.kind_id=aggView6010232676976619217.v17 and production_year>2008);
create or replace view aggJoin8327278070849310548 as (
with aggView5277245874332433624 as (select v37, MIN(v38) as v51 from aggJoin8269405123077759594 group by v37)
select v37, v23, v49 as v49, v51 from aggJoin1911535712436165474 join aggView5277245874332433624 using(v37));
create or replace view aggJoin5431965731531869537 as (
with aggView6305805800781282034 as (select v37, MIN(v49) as v49, MIN(v51) as v51 from aggJoin8327278070849310548 group by v37,v49,v51)
select movie_id as v37, keyword_id as v14, v49, v51 from movie_keyword as mk, aggView6305805800781282034 where mk.movie_id=aggView6305805800781282034.v37);
create or replace view aggJoin715656765201333183 as (
with aggView4887592568201130888 as (select id as v10 from info_type as it1 where info= 'countries')
select v37, v27, v50 from aggJoin5425613047160957498 join aggView4887592568201130888 using(v10));
create or replace view aggJoin7445923128960238088 as (
with aggView1532351280806009244 as (select v37, MIN(v50) as v50 from aggJoin715656765201333183 group by v37,v50)
select v14, v49 as v49, v51 as v51, v50 from aggJoin5431965731531869537 join aggView1532351280806009244 using(v37));
create or replace view aggJoin4025047266629059274 as (
with aggView5508652147496627479 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v51, v50 from aggJoin7445923128960238088 join aggView5508652147496627479 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin4025047266629059274;
