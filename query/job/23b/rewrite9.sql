create or replace view aggJoin3092546293889419351 as (
with aggView709853688911549190 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView709853688911549190 where t.kind_id=aggView709853688911549190.v21 and production_year>2000);
create or replace view aggJoin8665522938070145554 as (
with aggView8825605415308868593 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView8825605415308868593 where mi.info_type_id=aggView8825605415308868593.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin4592836156579671301 as (
with aggView8702642880541900493 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView8702642880541900493 where mc.company_type_id=aggView8702642880541900493.v14);
create or replace view aggJoin122585102704711697 as (
with aggView3683081071216411478 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView3683081071216411478 where mk.keyword_id=aggView3683081071216411478.v18);
create or replace view aggJoin8345998490620750014 as (
with aggView7422665502964772149 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView7422665502964772149 where cc.status_id=aggView7422665502964772149.v5);
create or replace view aggJoin1644182115732845213 as (
with aggView8795900677678490889 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin4592836156579671301 join aggView8795900677678490889 using(v7));
create or replace view aggJoin5042250229485405901 as (
with aggView7756572443634699347 as (select v36 from aggJoin8345998490620750014 group by v36)
select v36 from aggJoin122585102704711697 join aggView7756572443634699347 using(v36));
create or replace view aggJoin7011972304521945007 as (
with aggView4406926160795113243 as (select v36 from aggJoin8665522938070145554 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin3092546293889419351 join aggView4406926160795113243 using(v36));
create or replace view aggJoin4269794715792714249 as (
with aggView1312462736157128271 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin7011972304521945007 group by v36,v48)
select v36, v48, v49 from aggJoin1644182115732845213 join aggView1312462736157128271 using(v36));
create or replace view aggJoin6549622781384273253 as (
with aggView3545132456964909375 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin4269794715792714249 group by v36,v48,v49)
select v48, v49 from aggJoin5042250229485405901 join aggView3545132456964909375 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin6549622781384273253;
