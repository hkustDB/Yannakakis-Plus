create or replace view aggJoin3072766640351177454 as (
with aggView4485222602443237705 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView4485222602443237705 where mc1.company_id=aggView4485222602443237705.v1);
create or replace view aggJoin8123003870699478438 as (
with aggView7930447448413740348 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView7930447448413740348 where mc2.company_id=aggView7930447448413740348.v8);
create or replace view aggJoin831241617718368483 as (
with aggView3595518498286694869 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView3595518498286694869 where mi_idx1.info_type_id=aggView3595518498286694869.v15);
create or replace view aggJoin3955210916042319407 as (
with aggView8710024280850866387 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView8710024280850866387 where t1.kind_id=aggView8710024280850866387.v19);
create or replace view aggJoin1618946592200469285 as (
with aggView3508081639807181378 as (select v49, MIN(v50) as v77 from aggJoin3955210916042319407 group by v49)
select v49, v38, v77 from aggJoin831241617718368483 join aggView3508081639807181378 using(v49));
create or replace view aggJoin2873311115198605164 as (
with aggView7726622363682676890 as (select v49, MIN(v77) as v77, MIN(v38) as v75 from aggJoin1618946592200469285 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v77, v75 from movie_link as ml, aggView7726622363682676890 where ml.movie_id=aggView7726622363682676890.v49);
create or replace view aggJoin6904941866051498787 as (
with aggView6771115455644051043 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView6771115455644051043 where t2.kind_id=aggView6771115455644051043.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin451303751250110740 as (
with aggView861677098853949254 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView861677098853949254 where mi_idx2.info_type_id=aggView861677098853949254.v17 and info<'3.5');
create or replace view aggJoin8452224125295284159 as (
with aggView4430022997769747132 as (select v61, MIN(v74) as v74 from aggJoin8123003870699478438 group by v61)
select v61, v43, v74 from aggJoin451303751250110740 join aggView4430022997769747132 using(v61));
create or replace view aggJoin1212748615922660396 as (
with aggView5742375080777277741 as (select v61, MIN(v74) as v74, MIN(v43) as v76 from aggJoin8452224125295284159 group by v61)
select v61, v62, v65, v74, v76 from aggJoin6904941866051498787 join aggView5742375080777277741 using(v61));
create or replace view aggJoin3883671792753972552 as (
with aggView4203861935983753832 as (select v61, MIN(v74) as v74, MIN(v76) as v76, MIN(v62) as v78 from aggJoin1212748615922660396 group by v61)
select v49, v23, v77 as v77, v75 as v75, v74, v76, v78 from aggJoin2873311115198605164 join aggView4203861935983753832 using(v61));
create or replace view aggJoin2521585282466625133 as (
with aggView7264592757357159513 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v77, v75, v74, v76, v78 from aggJoin3883671792753972552 join aggView7264592757357159513 using(v23));
create or replace view aggJoin4650071335500656531 as (
with aggView8653822529542064992 as (select v49, MIN(v77) as v77, MIN(v75) as v75, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin2521585282466625133 group by v49)
select v73 as v73, v77, v75, v74, v76, v78 from aggJoin3072766640351177454 join aggView8653822529542064992 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin4650071335500656531;
