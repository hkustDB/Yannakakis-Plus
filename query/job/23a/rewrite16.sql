create or replace view aggJoin2623505690196236419 as (
with aggView5285030087409079251 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView5285030087409079251 where mc.company_type_id=aggView5285030087409079251.v14);
create or replace view aggJoin5453693552593479337 as (
with aggView2500313962067452237 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView2500313962067452237 where mk.keyword_id=aggView2500313962067452237.v18);
create or replace view aggJoin1279662986083631727 as (
with aggView4783347034196136668 as (select v36 from aggJoin5453693552593479337 group by v36)
select v36, v7 from aggJoin2623505690196236419 join aggView4783347034196136668 using(v36));
create or replace view aggJoin3924614612952158934 as (
with aggView7639412948993333437 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView7639412948993333437 where mi.info_type_id=aggView7639412948993333437.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin8646574023044830148 as (
with aggView6677244018404400004 as (select v36 from aggJoin3924614612952158934 group by v36)
select v36, v7 from aggJoin1279662986083631727 join aggView6677244018404400004 using(v36));
create or replace view aggJoin1760101648612426445 as (
with aggView6046196526690164439 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView6046196526690164439 where cc.status_id=aggView6046196526690164439.v5);
create or replace view aggJoin8104321010987082882 as (
with aggView676760744684367764 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin8646574023044830148 join aggView676760744684367764 using(v7));
create or replace view aggJoin5403257519140637216 as (
with aggView8481390080376704876 as (select v36 from aggJoin8104321010987082882 group by v36)
select v36 from aggJoin1760101648612426445 join aggView8481390080376704876 using(v36));
create or replace view aggJoin6236716637717018607 as (
with aggView8731649604447642137 as (select v36 from aggJoin5403257519140637216 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView8731649604447642137 where t.id=aggView8731649604447642137.v36 and production_year>2000);
create or replace view aggView9204347678199923135 as select v21, v37 from aggJoin6236716637717018607 group by v21,v37;
create or replace view aggJoin3962416516296341426 as (
with aggView6460336672209343762 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select v37, v48 from aggView9204347678199923135 join aggView6460336672209343762 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin3962416516296341426;
