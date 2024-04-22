create or replace view aggJoin7040008534032088522 as (
with aggView7952910751813496454 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView7952910751813496454 where mc2.company_id=aggView7952910751813496454.v8);
create or replace view aggJoin1437431902499487861 as (
with aggView835679546776904579 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView835679546776904579 where mc1.company_id=aggView835679546776904579.v1);
create or replace view aggJoin6110439190534287982 as (
with aggView7359294988263649691 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView7359294988263649691 where mi_idx2.info_type_id=aggView7359294988263649691.v17 and info<'3.5');
create or replace view aggJoin3751911732287314597 as (
with aggView3291607931649025030 as (select v61, MIN(v43) as v76 from aggJoin6110439190534287982 group by v61)
select v61, v74 as v74, v76 from aggJoin7040008534032088522 join aggView3291607931649025030 using(v61));
create or replace view aggJoin4775069975753728415 as (
with aggView6201552346143075517 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView6201552346143075517 where t2.kind_id=aggView6201552346143075517.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin904492548534333456 as (
with aggView7168622881665176690 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView7168622881665176690 where t1.kind_id=aggView7168622881665176690.v19);
create or replace view aggJoin7633847168043744904 as (
with aggView3309507610001878482 as (select v49, MIN(v50) as v77 from aggJoin904492548534333456 group by v49)
select v49, v73 as v73, v77 from aggJoin1437431902499487861 join aggView3309507610001878482 using(v49));
create or replace view aggJoin558992660968308694 as (
with aggView7689771843341461174 as (select v49, MIN(v73) as v73, MIN(v77) as v77 from aggJoin7633847168043744904 group by v49,v77,v73)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v73, v77 from movie_link as ml, aggView7689771843341461174 where ml.movie_id=aggView7689771843341461174.v49);
create or replace view aggJoin8299034369035334392 as (
with aggView4811356486274475717 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v73, v77 from aggJoin558992660968308694 join aggView4811356486274475717 using(v23));
create or replace view aggJoin8750726898906556874 as (
with aggView5768850712656576363 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView5768850712656576363 where mi_idx1.info_type_id=aggView5768850712656576363.v15);
create or replace view aggJoin2532799794292561520 as (
with aggView5400736246783148946 as (select v49, MIN(v38) as v75 from aggJoin8750726898906556874 group by v49)
select v61, v73 as v73, v77 as v77, v75 from aggJoin8299034369035334392 join aggView5400736246783148946 using(v49));
create or replace view aggJoin625102686780631902 as (
with aggView7573218456822752957 as (select v61, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75 from aggJoin2532799794292561520 group by v61,v77,v75,v73)
select v61, v62, v65, v73, v77, v75 from aggJoin4775069975753728415 join aggView7573218456822752957 using(v61));
create or replace view aggJoin7039209759618590278 as (
with aggView2733632844803014945 as (select v61, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75, MIN(v62) as v78 from aggJoin625102686780631902 group by v61,v77,v75,v73)
select v74 as v74, v76 as v76, v73, v77, v75, v78 from aggJoin3751911732287314597 join aggView2733632844803014945 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin7039209759618590278;
