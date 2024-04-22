create or replace view aggJoin8253845170712343817 as (
with aggView2463480500519169113 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView2463480500519169113 where t.kind_id=aggView2463480500519169113.v21 and production_year>1990);
create or replace view aggJoin1586884975884194553 as (
with aggView318810659183057438 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin8253845170712343817 group by v36,v48)
select movie_id as v36, status_id as v5, v48, v49 from complete_cast as cc, aggView318810659183057438 where cc.movie_id=aggView318810659183057438.v36);
create or replace view aggJoin8287713813053303517 as (
with aggView5764848674854415948 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView5764848674854415948 where mi.info_type_id=aggView5764848674854415948.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin2486883346656652584 as (
with aggView2992253343593452691 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView2992253343593452691 where mc.company_type_id=aggView2992253343593452691.v14);
create or replace view aggJoin1821644061721934702 as (
with aggView952152871653641426 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView952152871653641426 where mk.keyword_id=aggView952152871653641426.v18);
create or replace view aggJoin8384641128821983920 as (
with aggView5299663172170236027 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin2486883346656652584 join aggView5299663172170236027 using(v7));
create or replace view aggJoin8777153554188621773 as (
with aggView7919423440037590821 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select v36, v48, v49 from aggJoin1586884975884194553 join aggView7919423440037590821 using(v5));
create or replace view aggJoin1462137853248921378 as (
with aggView1124383686445637171 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin8777153554188621773 group by v36,v49,v48)
select v36, v31, v32, v48, v49 from aggJoin8287713813053303517 join aggView1124383686445637171 using(v36));
create or replace view aggJoin8632993759394795435 as (
with aggView5236331632067459222 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin1462137853248921378 group by v36,v49,v48)
select v36, v48, v49 from aggJoin8384641128821983920 join aggView5236331632067459222 using(v36));
create or replace view aggJoin2096182458796920094 as (
with aggView1343196921270281961 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin8632993759394795435 group by v36,v49,v48)
select v48, v49 from aggJoin1821644061721934702 join aggView1343196921270281961 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin2096182458796920094;
