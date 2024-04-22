create or replace view aggJoin8678748176229002256 as (
with aggView733332362038201248 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView733332362038201248 where t.kind_id=aggView733332362038201248.v21 and production_year>2000);
create or replace view aggJoin1064906763090909808 as (
with aggView6773894994417259655 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView6773894994417259655 where mc.company_type_id=aggView6773894994417259655.v14);
create or replace view aggJoin7184808152666133260 as (
with aggView616465188198226053 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView616465188198226053 where mi.info_type_id=aggView616465188198226053.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin4113582748257846452 as (
with aggView1151111507113306577 as (select v36 from aggJoin7184808152666133260 group by v36)
select v36, v7 from aggJoin1064906763090909808 join aggView1151111507113306577 using(v36));
create or replace view aggJoin5093311777698880940 as (
with aggView3966822459695809350 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView3966822459695809350 where mk.keyword_id=aggView3966822459695809350.v18);
create or replace view aggJoin5371613305149540312 as (
with aggView2294043850252469283 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView2294043850252469283 where cc.status_id=aggView2294043850252469283.v5);
create or replace view aggJoin515574555920644960 as (
with aggView8672504943004311600 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin4113582748257846452 join aggView8672504943004311600 using(v7));
create or replace view aggJoin864360973964221267 as (
with aggView6630986279063047810 as (select v36 from aggJoin515574555920644960 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin8678748176229002256 join aggView6630986279063047810 using(v36));
create or replace view aggJoin4318739530100659359 as (
with aggView5761827140722824591 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin864360973964221267 group by v36,v48)
select v36, v48, v49 from aggJoin5371613305149540312 join aggView5761827140722824591 using(v36));
create or replace view aggJoin3970009636870848596 as (
with aggView2352431582776415634 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin4318739530100659359 group by v36,v49,v48)
select v48, v49 from aggJoin5093311777698880940 join aggView2352431582776415634 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin3970009636870848596;
