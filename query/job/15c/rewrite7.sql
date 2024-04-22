create or replace view aggJoin1293093862268948934 as (
with aggView7820022497895911563 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView7820022497895911563 where mc.company_id=aggView7820022497895911563.v13);
create or replace view aggJoin8685249422895772211 as (
with aggView7365109536957695011 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView7365109536957695011 where mk.keyword_id=aggView7365109536957695011.v24);
create or replace view aggJoin4010253083243958539 as (
with aggView5253322600917152355 as (select id as v20 from company_type as ct)
select v40 from aggJoin1293093862268948934 join aggView5253322600917152355 using(v20));
create or replace view aggJoin5261870114104300167 as (
with aggView5740397846808478246 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40 from aggJoin8685249422895772211 join aggView5740397846808478246 using(v40));
create or replace view aggJoin8053541371574692340 as (
with aggView7510984735309484492 as (select v40 from aggJoin4010253083243958539 group by v40)
select v40 from aggJoin5261870114104300167 join aggView7510984735309484492 using(v40));
create or replace view aggJoin7355865477879457062 as (
with aggView865866546537696681 as (select v40 from aggJoin8053541371574692340 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView865866546537696681 where t.id=aggView865866546537696681.v40 and production_year>1990);
create or replace view aggView2956062820016862787 as select v41, v40 from aggJoin7355865477879457062 group by v41,v40;
create or replace view aggJoin6079404600906587282 as (
with aggView2778731723395822545 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView2778731723395822545 where mi.info_type_id=aggView2778731723395822545.v22 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggView6758146994349812278 as select v40, v35 from aggJoin6079404600906587282 group by v40,v35;
create or replace view aggJoin3973319714746609955 as (
with aggView8348470340353032660 as (select v40, MIN(v41) as v53 from aggView2956062820016862787 group by v40)
select v35, v53 from aggView6758146994349812278 join aggView8348470340353032660 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin3973319714746609955;
