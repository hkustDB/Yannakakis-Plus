create or replace view aggView9170297643749386540 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin2492202419855455731 as (
with aggView4024297052445155395 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView4024297052445155395 where mi_idx.info_type_id=aggView4024297052445155395.v20 and info>'6.5');
create or replace view aggView8287448119098793212 as select v45, v40 from aggJoin2492202419855455731 group by v45,v40;
create or replace view aggJoin1743390097343519444 as (
with aggView9158670425684994338 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView9158670425684994338 where t.kind_id=aggView9158670425684994338.v25 and production_year>2005);
create or replace view aggView8594296995082384155 as select v46, v45 from aggJoin1743390097343519444 group by v46,v45;
create or replace view aggJoin8727950023095864964 as (
with aggView2344087844137215863 as (select v9, MIN(v10) as v57 from aggView9170297643749386540 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView2344087844137215863 where mc.company_id=aggView2344087844137215863.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin6259733062770126326 as (
with aggView5515830180099943427 as (select v45, MIN(v46) as v59 from aggView8594296995082384155 group by v45)
select v45, v40, v59 from aggView8287448119098793212 join aggView5515830180099943427 using(v45));
create or replace view aggJoin5958071477086091835 as (
with aggView659041645244997924 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView659041645244997924 where cc.status_id=aggView659041645244997924.v7);
create or replace view aggJoin3892392273562670498 as (
with aggView6932231640521500478 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin8727950023095864964 join aggView6932231640521500478 using(v16));
create or replace view aggJoin6065668678393918001 as (
with aggView174541863029665540 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin5958071477086091835 join aggView174541863029665540 using(v5));
create or replace view aggJoin4964723826086589895 as (
with aggView9213170401303258586 as (select v45 from aggJoin6065668678393918001 group by v45)
select v45, v31, v57 as v57 from aggJoin3892392273562670498 join aggView9213170401303258586 using(v45));
create or replace view aggJoin2474023046281937594 as (
with aggView680931560273165237 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView680931560273165237 where mk.keyword_id=aggView680931560273165237.v22);
create or replace view aggJoin6294455515751119995 as (
with aggView6837574999886036100 as (select v45 from aggJoin2474023046281937594 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView6837574999886036100 where mi.movie_id=aggView6837574999886036100.v45 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin3005546692141752283 as (
with aggView2495644331149606571 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin6294455515751119995 join aggView2495644331149606571 using(v18));
create or replace view aggJoin6348294414486560355 as (
with aggView6181155981313165319 as (select v45 from aggJoin3005546692141752283 group by v45)
select v45, v31, v57 as v57 from aggJoin4964723826086589895 join aggView6181155981313165319 using(v45));
create or replace view aggJoin8484050790802756204 as (
with aggView3115769845812386126 as (select v45, MIN(v57) as v57 from aggJoin6348294414486560355 group by v45,v57)
select v40, v59 as v59, v57 from aggJoin6259733062770126326 join aggView3115769845812386126 using(v45));
select MIN(v57) as v57,MIN(v40) as v58,MIN(v59) as v59 from aggJoin8484050790802756204;
