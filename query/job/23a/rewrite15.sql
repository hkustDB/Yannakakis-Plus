create or replace view aggJoin4943136445702187665 as (
with aggView5083885022638299745 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView5083885022638299745 where t.kind_id=aggView5083885022638299745.v21 and production_year>2000);
create or replace view aggJoin5920589027337019848 as (
with aggView6569802511485631522 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin4943136445702187665 group by v36,v48)
select movie_id as v36, company_id as v7, company_type_id as v14, v48, v49 from movie_companies as mc, aggView6569802511485631522 where mc.movie_id=aggView6569802511485631522.v36);
create or replace view aggJoin336829828436043410 as (
with aggView1687759970570939342 as (select id as v14 from company_type as ct)
select v36, v7, v48, v49 from aggJoin5920589027337019848 join aggView1687759970570939342 using(v14));
create or replace view aggJoin6771211371114610039 as (
with aggView2185708552156377119 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView2185708552156377119 where mi.info_type_id=aggView2185708552156377119.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin530563093639981109 as (
with aggView7774352083630764921 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView7774352083630764921 where mk.keyword_id=aggView7774352083630764921.v18);
create or replace view aggJoin8413026141987343044 as (
with aggView6530086304197819959 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView6530086304197819959 where cc.status_id=aggView6530086304197819959.v5);
create or replace view aggJoin8145975444644059608 as (
with aggView2858296282141843085 as (select v36 from aggJoin6771211371114610039 group by v36)
select v36 from aggJoin8413026141987343044 join aggView2858296282141843085 using(v36));
create or replace view aggJoin3358045839742629096 as (
with aggView1164167347261645634 as (select v36 from aggJoin8145975444644059608 group by v36)
select v36 from aggJoin530563093639981109 join aggView1164167347261645634 using(v36));
create or replace view aggJoin4847744529336012464 as (
with aggView7501831342884148639 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36, v48, v49 from aggJoin336829828436043410 join aggView7501831342884148639 using(v7));
create or replace view aggJoin119711443450039479 as (
with aggView3342797280627308512 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin4847744529336012464 group by v36,v49,v48)
select v48, v49 from aggJoin3358045839742629096 join aggView3342797280627308512 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin119711443450039479;
