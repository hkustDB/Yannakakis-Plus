create or replace view aggJoin6513769278035787381 as (
with aggView7748112769178656363 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView7748112769178656363 where t.kind_id=aggView7748112769178656363.v21 and production_year>2000);
create or replace view aggJoin7375630392488724320 as (
with aggView9029250332877315469 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin6513769278035787381 group by v36,v48)
select movie_id as v36, keyword_id as v18, v48, v49 from movie_keyword as mk, aggView9029250332877315469 where mk.movie_id=aggView9029250332877315469.v36);
create or replace view aggJoin5438250559883343900 as (
with aggView3543018964695982612 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView3543018964695982612 where mc.company_type_id=aggView3543018964695982612.v14);
create or replace view aggJoin8666132484692127891 as (
with aggView938810982730002856 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView938810982730002856 where mi.info_type_id=aggView938810982730002856.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin8006305593936254455 as (
with aggView3873610435980503699 as (select id as v18 from keyword as k)
select v36, v48, v49 from aggJoin7375630392488724320 join aggView3873610435980503699 using(v18));
create or replace view aggJoin581859041228864617 as (
with aggView6601721226917732771 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView6601721226917732771 where cc.status_id=aggView6601721226917732771.v5);
create or replace view aggJoin2924768907536636410 as (
with aggView4778906718551057126 as (select v36 from aggJoin581859041228864617 group by v36)
select v36, v7 from aggJoin5438250559883343900 join aggView4778906718551057126 using(v36));
create or replace view aggJoin5976014959139607133 as (
with aggView3687892071674808897 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin2924768907536636410 join aggView3687892071674808897 using(v7));
create or replace view aggJoin524227686962800399 as (
with aggView5441554762808306228 as (select v36 from aggJoin5976014959139607133 group by v36)
select v36, v31, v32 from aggJoin8666132484692127891 join aggView5441554762808306228 using(v36));
create or replace view aggJoin4992152063583805628 as (
with aggView8396333843681205524 as (select v36 from aggJoin524227686962800399 group by v36)
select v48 as v48, v49 as v49 from aggJoin8006305593936254455 join aggView8396333843681205524 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin4992152063583805628;
