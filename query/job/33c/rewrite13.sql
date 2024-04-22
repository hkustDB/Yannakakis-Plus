create or replace view aggView3498416780001788004 as select name as v2, id as v1 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView8323796061304588361 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggJoin1416117974475525805 as (
with aggView5573445960426316265 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView5573445960426316265 where mi_idx2.info_type_id=aggView5573445960426316265.v17);
create or replace view aggJoin247385293964822277 as (
with aggView6495019253281749363 as (select v61, v43 from aggJoin1416117974475525805 group by v61,v43)
select v61, v43 from aggView6495019253281749363 where v43<'3.5');
create or replace view aggJoin4909962346510873397 as (
with aggView3449648862605348967 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView3449648862605348967 where t2.kind_id=aggView3449648862605348967.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView8275974359623379723 as select v61, v62 from aggJoin4909962346510873397 group by v61,v62;
create or replace view aggJoin195287082631597520 as (
with aggView3585212602581931208 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView3585212602581931208 where t1.kind_id=aggView3585212602581931208.v19);
create or replace view aggView7244853684605154873 as select v50, v49 from aggJoin195287082631597520 group by v50,v49;
create or replace view aggJoin857480519941795104 as (
with aggView8230690589481380206 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView8230690589481380206 where mi_idx1.info_type_id=aggView8230690589481380206.v15);
create or replace view aggView6396731100270595956 as select v38, v49 from aggJoin857480519941795104 group by v38,v49;
create or replace view aggJoin589506761580393034 as (
with aggView7273228348565707893 as (select v8, MIN(v9) as v74 from aggView8323796061304588361 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView7273228348565707893 where mc2.company_id=aggView7273228348565707893.v8);
create or replace view aggJoin1046081393258506732 as (
with aggView6068347886120594097 as (select v49, MIN(v38) as v75 from aggView6396731100270595956 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v75 from movie_link as ml, aggView6068347886120594097 where ml.movie_id=aggView6068347886120594097.v49);
create or replace view aggJoin3884063685734610806 as (
with aggView1611191128658818848 as (select v61, MIN(v62) as v78 from aggView8275974359623379723 group by v61)
select v49, v61, v23, v75 as v75, v78 from aggJoin1046081393258506732 join aggView1611191128658818848 using(v61));
create or replace view aggJoin584308157576487367 as (
with aggView7832722534012502564 as (select v61, MIN(v43) as v76 from aggJoin247385293964822277 group by v61)
select v61, v74 as v74, v76 from aggJoin589506761580393034 join aggView7832722534012502564 using(v61));
create or replace view aggJoin404788005329067068 as (
with aggView8895900509545873322 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v75, v78 from aggJoin3884063685734610806 join aggView8895900509545873322 using(v23));
create or replace view aggJoin2888561768624178138 as (
with aggView280075639172348635 as (select v61, MIN(v74) as v74, MIN(v76) as v76 from aggJoin584308157576487367 group by v61,v74,v76)
select v49, v75 as v75, v78 as v78, v74, v76 from aggJoin404788005329067068 join aggView280075639172348635 using(v61));
create or replace view aggJoin5521649592061837562 as (
with aggView3308992858341371223 as (select v49, MIN(v75) as v75, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76 from aggJoin2888561768624178138 group by v49,v74,v75,v76,v78)
select v50, v49, v75, v78, v74, v76 from aggView7244853684605154873 join aggView3308992858341371223 using(v49));
create or replace view aggJoin7903181807420076078 as (
with aggView7513620546646452656 as (select v49, MIN(v75) as v75, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76, MIN(v50) as v77 from aggJoin5521649592061837562 group by v49,v74,v75,v76,v78)
select company_id as v1, v75, v78, v74, v76, v77 from movie_companies as mc1, aggView7513620546646452656 where mc1.movie_id=aggView7513620546646452656.v49);
create or replace view aggJoin5782648429372009770 as (
with aggView2635030953519098830 as (select v1, MIN(v75) as v75, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76, MIN(v77) as v77 from aggJoin7903181807420076078 group by v1,v75,v76,v74,v77,v78)
select v2, v75, v78, v74, v76, v77 from aggView3498416780001788004 join aggView2635030953519098830 using(v1));
select MIN(v2) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin5782648429372009770;
