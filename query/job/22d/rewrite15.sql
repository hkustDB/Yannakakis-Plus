create or replace view aggJoin1746304535151402980 as (
with aggView5756859735625564345 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView5756859735625564345 where mc.company_id=aggView5756859735625564345.v1);
create or replace view aggJoin8714349485930039338 as (
with aggView4009580510704269265 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView4009580510704269265 where mi.info_type_id=aggView4009580510704269265.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin5165101495887380423 as (
with aggView2332353765302084090 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView2332353765302084090 where mk.keyword_id=aggView2332353765302084090.v14);
create or replace view aggJoin2785076670679685917 as (
with aggView7144282080820265373 as (select v37 from aggJoin8714349485930039338 group by v37)
select id as v37, title as v38, kind_id as v17, production_year as v41 from title as t, aggView7144282080820265373 where t.id=aggView7144282080820265373.v37 and production_year>2005);
create or replace view aggJoin5933402351990222821 as (
with aggView5207254256077560579 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView5207254256077560579 where mi_idx.info_type_id=aggView5207254256077560579.v12 and info<'8.5');
create or replace view aggJoin8470687231248138467 as (
with aggView9131531549298871777 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin1746304535151402980 join aggView9131531549298871777 using(v8));
create or replace view aggJoin1824533177756994399 as (
with aggView7283378979884688950 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41 from aggJoin2785076670679685917 join aggView7283378979884688950 using(v17));
create or replace view aggJoin7595247727638156984 as (
with aggView7954485180908907373 as (select v37, MIN(v38) as v51 from aggJoin1824533177756994399 group by v37)
select v37, v32, v51 from aggJoin5933402351990222821 join aggView7954485180908907373 using(v37));
create or replace view aggJoin2518280443639833174 as (
with aggView3942955555217264188 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin7595247727638156984 group by v37,v51)
select v37, v49 as v49, v51, v50 from aggJoin8470687231248138467 join aggView3942955555217264188 using(v37));
create or replace view aggJoin4163719007744463271 as (
with aggView6455160910546285461 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v50) as v50 from aggJoin2518280443639833174 group by v37,v51,v50,v49)
select v49, v51, v50 from aggJoin5165101495887380423 join aggView6455160910546285461 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin4163719007744463271;
