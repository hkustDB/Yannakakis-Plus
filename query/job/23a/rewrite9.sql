create or replace view aggJoin5136372013035187984 as (
with aggView3851448753166356762 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView3851448753166356762 where t.kind_id=aggView3851448753166356762.v21 and production_year>2000);
create or replace view aggJoin4694759771749187028 as (
with aggView152647637497466312 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin5136372013035187984 group by v36,v48)
select movie_id as v36, status_id as v5, v48, v49 from complete_cast as cc, aggView152647637497466312 where cc.movie_id=aggView152647637497466312.v36);
create or replace view aggJoin8200786474516851597 as (
with aggView5778027189028276536 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView5778027189028276536 where mc.company_type_id=aggView5778027189028276536.v14);
create or replace view aggJoin6637027615911808105 as (
with aggView4284517955255987605 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView4284517955255987605 where mk.keyword_id=aggView4284517955255987605.v18);
create or replace view aggJoin3356230843756569268 as (
with aggView9032109751892638308 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView9032109751892638308 where mi.info_type_id=aggView9032109751892638308.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin2402936939954288497 as (
with aggView1296755878345077468 as (select v36 from aggJoin3356230843756569268 group by v36)
select v36, v7 from aggJoin8200786474516851597 join aggView1296755878345077468 using(v36));
create or replace view aggJoin4369533223038698439 as (
with aggView5095073164663785866 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select v36, v48, v49 from aggJoin4694759771749187028 join aggView5095073164663785866 using(v5));
create or replace view aggJoin3504680939286700597 as (
with aggView4463257745173374459 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin4369533223038698439 group by v36,v49,v48)
select v36, v48, v49 from aggJoin6637027615911808105 join aggView4463257745173374459 using(v36));
create or replace view aggJoin1940766695599207804 as (
with aggView8513063471629199739 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin2402936939954288497 join aggView8513063471629199739 using(v7));
create or replace view aggJoin1166359619302135282 as (
with aggView9085779978749946743 as (select v36 from aggJoin1940766695599207804 group by v36)
select v48 as v48, v49 as v49 from aggJoin3504680939286700597 join aggView9085779978749946743 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin1166359619302135282;
