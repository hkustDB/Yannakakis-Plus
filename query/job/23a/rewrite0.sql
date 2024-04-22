create or replace view aggJoin4019020080747434866 as (
with aggView5534399571806453602 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView5534399571806453602 where mc.company_type_id=aggView5534399571806453602.v14);
create or replace view aggJoin8797590382297064557 as (
with aggView7215755575401619318 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView7215755575401619318 where mk.keyword_id=aggView7215755575401619318.v18);
create or replace view aggJoin7713396558780779099 as (
with aggView6293944634150492502 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView6293944634150492502 where mi.info_type_id=aggView6293944634150492502.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin7526349677134327429 as (
with aggView3182779543563085930 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView3182779543563085930 where cc.status_id=aggView3182779543563085930.v5);
create or replace view aggJoin7010223640849279366 as (
with aggView7066541029525605800 as (select v36 from aggJoin7526349677134327429 group by v36)
select v36 from aggJoin8797590382297064557 join aggView7066541029525605800 using(v36));
create or replace view aggJoin4540258798599731786 as (
with aggView5962987985781669441 as (select v36 from aggJoin7010223640849279366 group by v36)
select id as v36, title as v37, kind_id as v21, production_year as v40 from title as t, aggView5962987985781669441 where t.id=aggView5962987985781669441.v36 and production_year>2000);
create or replace view aggJoin4752182419680759289 as (
with aggView8456167108951330301 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin4019020080747434866 join aggView8456167108951330301 using(v7));
create or replace view aggJoin8659547362003799822 as (
with aggView8188342876723376293 as (select v36 from aggJoin4752182419680759289 group by v36)
select v36, v31, v32 from aggJoin7713396558780779099 join aggView8188342876723376293 using(v36));
create or replace view aggJoin6147108822396379115 as (
with aggView1582761931114754633 as (select v36 from aggJoin8659547362003799822 group by v36)
select v37, v21, v40 from aggJoin4540258798599731786 join aggView1582761931114754633 using(v36));
create or replace view aggView6875291136142737783 as select v21, v37 from aggJoin6147108822396379115 group by v21,v37;
create or replace view aggJoin4470218280019341869 as (
with aggView4382024522940072880 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select v37, v48 from aggView6875291136142737783 join aggView4382024522940072880 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin4470218280019341869;
