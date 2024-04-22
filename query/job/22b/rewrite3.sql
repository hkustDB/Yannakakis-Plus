create or replace view aggView1371334077929724800 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin1012116360653854030 as (
with aggView6586112149823818769 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView6586112149823818769 where mi_idx.info_type_id=aggView6586112149823818769.v12 and info<'7.0');
create or replace view aggJoin1988034567791122758 as (
with aggView9133236650607127816 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView9133236650607127816 where t.kind_id=aggView9133236650607127816.v17 and production_year>2009);
create or replace view aggView8968548163846468073 as select v38, v37 from aggJoin1988034567791122758 group by v38,v37;
create or replace view aggJoin3700026251148865614 as (
with aggView755901898767650963 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView755901898767650963 where mi.info_type_id=aggView755901898767650963.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin5005826440311247886 as (
with aggView6538632068007485637 as (select v37 from aggJoin3700026251148865614 group by v37)
select v37, v32 from aggJoin1012116360653854030 join aggView6538632068007485637 using(v37));
create or replace view aggView7224585334594120142 as select v37, v32 from aggJoin5005826440311247886 group by v37,v32;
create or replace view aggJoin5982573184873357881 as (
with aggView1884281071166019995 as (select v37, MIN(v32) as v50 from aggView7224585334594120142 group by v37)
select v38, v37, v50 from aggView8968548163846468073 join aggView1884281071166019995 using(v37));
create or replace view aggJoin6939915045435245871 as (
with aggView4076862279682849869 as (select v37, MIN(v50) as v50, MIN(v38) as v51 from aggJoin5982573184873357881 group by v37,v50)
select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v50, v51 from movie_companies as mc, aggView4076862279682849869 where mc.movie_id=aggView4076862279682849869.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin6645582310282677417 as (
with aggView707076578303775190 as (select id as v8 from company_type as ct)
select v37, v1, v23, v50, v51 from aggJoin6939915045435245871 join aggView707076578303775190 using(v8));
create or replace view aggJoin1068117455435397408 as (
with aggView2809053350094051635 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView2809053350094051635 where mk.keyword_id=aggView2809053350094051635.v14);
create or replace view aggJoin2923692044837749192 as (
with aggView2037999346702445452 as (select v37 from aggJoin1068117455435397408 group by v37)
select v1, v23, v50 as v50, v51 as v51 from aggJoin6645582310282677417 join aggView2037999346702445452 using(v37));
create or replace view aggJoin2985127655508961278 as (
with aggView3588926940795907202 as (select v1, MIN(v50) as v50, MIN(v51) as v51 from aggJoin2923692044837749192 group by v1,v50,v51)
select v2, v50, v51 from aggView1371334077929724800 join aggView3588926940795907202 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin2985127655508961278;
