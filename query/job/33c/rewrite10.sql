create or replace view aggJoin5068305412248587262 as (
with aggView7365115578801418107 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView7365115578801418107 where mc2.company_id=aggView7365115578801418107.v8);
create or replace view aggJoin1538206239639957183 as (
with aggView6532760301053305183 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView6532760301053305183 where mc1.company_id=aggView6532760301053305183.v1);
create or replace view aggJoin5245359474851568435 as (
with aggView4081940884018336515 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView4081940884018336515 where mi_idx2.info_type_id=aggView4081940884018336515.v17 and info<'3.5');
create or replace view aggJoin6323120299906581690 as (
with aggView4118689859335764329 as (select v61, MIN(v43) as v76 from aggJoin5245359474851568435 group by v61)
select id as v61, title as v62, kind_id as v21, production_year as v65, v76 from title as t2, aggView4118689859335764329 where t2.id=aggView4118689859335764329.v61 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin1691481936044129854 as (
with aggView436076274532605753 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select v61, v62, v65, v76 from aggJoin6323120299906581690 join aggView436076274532605753 using(v21));
create or replace view aggJoin4610658493624719139 as (
with aggView8373455963314565523 as (select v61, MIN(v76) as v76, MIN(v62) as v78 from aggJoin1691481936044129854 group by v61,v76)
select v61, v74 as v74, v76, v78 from aggJoin5068305412248587262 join aggView8373455963314565523 using(v61));
create or replace view aggJoin930373130931329659 as (
with aggView9139175532891888386 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView9139175532891888386 where t1.kind_id=aggView9139175532891888386.v19);
create or replace view aggJoin2642930726957722490 as (
with aggView9083966549688700809 as (select v49, MIN(v50) as v77 from aggJoin930373130931329659 group by v49)
select movie_id as v49, info_type_id as v15, info as v38, v77 from movie_info_idx as mi_idx1, aggView9083966549688700809 where mi_idx1.movie_id=aggView9083966549688700809.v49);
create or replace view aggJoin1237580584784050148 as (
with aggView2999778882748925282 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView2999778882748925282 where ml.link_type_id=aggView2999778882748925282.v23);
create or replace view aggJoin5347913384694001224 as (
with aggView4598725063549723703 as (select id as v15 from info_type as it1 where info= 'rating')
select v49, v38, v77 from aggJoin2642930726957722490 join aggView4598725063549723703 using(v15));
create or replace view aggJoin8443157274535465253 as (
with aggView5904556773391182036 as (select v61, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin4610658493624719139 group by v61,v74,v76,v78)
select v49, v74, v76, v78 from aggJoin1237580584784050148 join aggView5904556773391182036 using(v61));
create or replace view aggJoin3701444075939801016 as (
with aggView1726584507734328392 as (select v49, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin8443157274535465253 group by v49,v74,v76,v78)
select v49, v38, v77 as v77, v74, v76, v78 from aggJoin5347913384694001224 join aggView1726584507734328392 using(v49));
create or replace view aggJoin5152205929008019053 as (
with aggView1547906238550473560 as (select v49, MIN(v77) as v77, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78, MIN(v38) as v75 from aggJoin3701444075939801016 group by v49,v74,v77,v76,v78)
select v73 as v73, v77, v74, v76, v78, v75 from aggJoin1538206239639957183 join aggView1547906238550473560 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin5152205929008019053;
