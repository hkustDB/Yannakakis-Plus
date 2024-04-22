create or replace view aggJoin3239518921626192854 as (
with aggView227599378316010568 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView227599378316010568 where t.kind_id=aggView227599378316010568.v21 and production_year>1990);
create or replace view aggJoin6884016624194142673 as (
with aggView5358588693323167621 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin3239518921626192854 group by v36,v48)
select movie_id as v36, keyword_id as v18, v48, v49 from movie_keyword as mk, aggView5358588693323167621 where mk.movie_id=aggView5358588693323167621.v36);
create or replace view aggJoin1203445007713627943 as (
with aggView2702331601102418279 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView2702331601102418279 where mi.info_type_id=aggView2702331601102418279.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin2925147842218997022 as (
with aggView6309891273212756356 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView6309891273212756356 where mc.company_type_id=aggView6309891273212756356.v14);
create or replace view aggJoin1812972113423366445 as (
with aggView7615086503605079342 as (select id as v18 from keyword as k)
select v36, v48, v49 from aggJoin6884016624194142673 join aggView7615086503605079342 using(v18));
create or replace view aggJoin1984827218615222426 as (
with aggView2287899580930953369 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin2925147842218997022 join aggView2287899580930953369 using(v7));
create or replace view aggJoin611813601606878265 as (
with aggView1075905879182859702 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView1075905879182859702 where cc.status_id=aggView1075905879182859702.v5);
create or replace view aggJoin7392173121224287542 as (
with aggView2986127306568545102 as (select v36 from aggJoin1203445007713627943 group by v36)
select v36 from aggJoin1984827218615222426 join aggView2986127306568545102 using(v36));
create or replace view aggJoin793531329718113062 as (
with aggView1009848869673141279 as (select v36 from aggJoin7392173121224287542 group by v36)
select v36 from aggJoin611813601606878265 join aggView1009848869673141279 using(v36));
create or replace view aggJoin3554884200114768948 as (
with aggView3581374584750337223 as (select v36 from aggJoin793531329718113062 group by v36)
select v48 as v48, v49 as v49 from aggJoin1812972113423366445 join aggView3581374584750337223 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin3554884200114768948;
