create or replace view aggJoin7041549462685272694 as (
with aggView8909062940761617495 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView8909062940761617495 where t.kind_id=aggView8909062940761617495.v21 and production_year>2000);
create or replace view aggJoin316692850011557068 as (
with aggView6986679010973144974 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin7041549462685272694 group by v36,v48)
select movie_id as v36, keyword_id as v18, v48, v49 from movie_keyword as mk, aggView6986679010973144974 where mk.movie_id=aggView6986679010973144974.v36);
create or replace view aggJoin7119676689546299923 as (
with aggView7707289047235378125 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView7707289047235378125 where mc.company_type_id=aggView7707289047235378125.v14);
create or replace view aggJoin6027225138614652430 as (
with aggView7734294706593224153 as (select id as v18 from keyword as k)
select v36, v48, v49 from aggJoin316692850011557068 join aggView7734294706593224153 using(v18));
create or replace view aggJoin3437825209078686088 as (
with aggView586700730693805560 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView586700730693805560 where mi.info_type_id=aggView586700730693805560.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin953916391838228623 as (
with aggView482478057662648191 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView482478057662648191 where cc.status_id=aggView482478057662648191.v5);
create or replace view aggJoin4211704062350561895 as (
with aggView5325671646598387498 as (select v36 from aggJoin953916391838228623 group by v36)
select v36, v48 as v48, v49 as v49 from aggJoin6027225138614652430 join aggView5325671646598387498 using(v36));
create or replace view aggJoin5242714194718040714 as (
with aggView1974312235700519433 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin7119676689546299923 join aggView1974312235700519433 using(v7));
create or replace view aggJoin4268457137053743120 as (
with aggView760556433634482951 as (select v36 from aggJoin5242714194718040714 group by v36)
select v36, v31, v32 from aggJoin3437825209078686088 join aggView760556433634482951 using(v36));
create or replace view aggJoin7791669171145622920 as (
with aggView3602627261207015674 as (select v36 from aggJoin4268457137053743120 group by v36)
select v48 as v48, v49 as v49 from aggJoin4211704062350561895 join aggView3602627261207015674 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin7791669171145622920;
