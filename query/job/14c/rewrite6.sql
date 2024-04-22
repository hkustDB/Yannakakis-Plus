create or replace view aggJoin5355032718412614460 as (
with aggView238768774755902625 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView238768774755902625 where t.kind_id=aggView238768774755902625.v8 and production_year>2005);
create or replace view aggJoin1712271571218507946 as (
with aggView6637171533935125847 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView6637171533935125847 where mi_idx.info_type_id=aggView6637171533935125847.v3);
create or replace view aggJoin6416942648731335307 as (
with aggView4325584870023074361 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView4325584870023074361 where mk.keyword_id=aggView4325584870023074361.v5);
create or replace view aggJoin8962152432443111103 as (
with aggView1570373005187699104 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView1570373005187699104 where mi.info_type_id=aggView1570373005187699104.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin386082744857908186 as (
with aggView4960298424395328902 as (select v23 from aggJoin6416942648731335307 group by v23)
select v23, v18 from aggJoin1712271571218507946 join aggView4960298424395328902 using(v23));
create or replace view aggJoin2720429278107534641 as (
with aggView8164412835427390804 as (select v18, v23 from aggJoin386082744857908186 group by v18,v23)
select v23, v18 from aggView8164412835427390804 where v18<'8.5');
create or replace view aggJoin8045992150650213273 as (
with aggView5070692288677044969 as (select v23 from aggJoin8962152432443111103 group by v23)
select v23, v24, v27 from aggJoin5355032718412614460 join aggView5070692288677044969 using(v23));
create or replace view aggView4037759689146793980 as select v24, v23 from aggJoin8045992150650213273 group by v24,v23;
create or replace view aggJoin5037680242194332999 as (
with aggView6254878260467011723 as (select v23, MIN(v24) as v36 from aggView4037759689146793980 group by v23)
select v18, v36 from aggJoin2720429278107534641 join aggView6254878260467011723 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin5037680242194332999;
