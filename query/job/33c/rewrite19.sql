create or replace view aggJoin326495523943802300 as (
with aggView6046318165179745415 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView6046318165179745415 where mc2.company_id=aggView6046318165179745415.v8);
create or replace view aggJoin5202700957728642535 as (
with aggView9175329599850393965 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView9175329599850393965 where mc1.company_id=aggView9175329599850393965.v1);
create or replace view aggJoin6118763185242560732 as (
with aggView6732953417845877636 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView6732953417845877636 where mi_idx2.info_type_id=aggView6732953417845877636.v17 and info<'3.5');
create or replace view aggJoin7322595861181288871 as (
with aggView2548501645146488634 as (select v61, MIN(v43) as v76 from aggJoin6118763185242560732 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v76 from movie_link as ml, aggView2548501645146488634 where ml.linked_movie_id=aggView2548501645146488634.v61);
create or replace view aggJoin507140871050448711 as (
with aggView5994142950358626501 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView5994142950358626501 where t2.kind_id=aggView5994142950358626501.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin1022991563638076520 as (
with aggView3955617678547654963 as (select v61, MIN(v62) as v78 from aggJoin507140871050448711 group by v61)
select v49, v61, v23, v76 as v76, v78 from aggJoin7322595861181288871 join aggView3955617678547654963 using(v61));
create or replace view aggJoin5964550128993882620 as (
with aggView4030255358611785298 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView4030255358611785298 where t1.kind_id=aggView4030255358611785298.v19);
create or replace view aggJoin6741071676765788596 as (
with aggView7731223780261928612 as (select v49, MIN(v50) as v77 from aggJoin5964550128993882620 group by v49)
select v49, v73 as v73, v77 from aggJoin5202700957728642535 join aggView7731223780261928612 using(v49));
create or replace view aggJoin1082507156507660579 as (
with aggView3074167657646868223 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v76, v78 from aggJoin1022991563638076520 join aggView3074167657646868223 using(v23));
create or replace view aggJoin2801386164415169656 as (
with aggView4698552415429145240 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView4698552415429145240 where mi_idx1.info_type_id=aggView4698552415429145240.v15);
create or replace view aggJoin4492315339547644521 as (
with aggView1352819553853102359 as (select v49, MIN(v38) as v75 from aggJoin2801386164415169656 group by v49)
select v49, v61, v76 as v76, v78 as v78, v75 from aggJoin1082507156507660579 join aggView1352819553853102359 using(v49));
create or replace view aggJoin492914386605997134 as (
with aggView8515541718559122563 as (select v61, MIN(v74) as v74 from aggJoin326495523943802300 group by v61,v74)
select v49, v76 as v76, v78 as v78, v75 as v75, v74 from aggJoin4492315339547644521 join aggView8515541718559122563 using(v61));
create or replace view aggJoin4203249185785027846 as (
with aggView1279273891695215299 as (select v49, MIN(v76) as v76, MIN(v78) as v78, MIN(v75) as v75, MIN(v74) as v74 from aggJoin492914386605997134 group by v49,v74,v75,v76,v78)
select v73 as v73, v77 as v77, v76, v78, v75, v74 from aggJoin6741071676765788596 join aggView1279273891695215299 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin4203249185785027846;
