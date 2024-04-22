create or replace view aggJoin5728454795725030940 as (
with aggView2319338648783493597 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView2319338648783493597 where t.kind_id=aggView2319338648783493597.v21 and production_year>1990);
create or replace view aggJoin1788118798740762139 as (
with aggView7299285158955989346 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin5728454795725030940 group by v36,v48)
select movie_id as v36, keyword_id as v18, v48, v49 from movie_keyword as mk, aggView7299285158955989346 where mk.movie_id=aggView7299285158955989346.v36);
create or replace view aggJoin333935838451157857 as (
with aggView929778522845242467 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView929778522845242467 where mi.info_type_id=aggView929778522845242467.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin7864100912621910639 as (
with aggView3149816079630057442 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView3149816079630057442 where mc.company_type_id=aggView3149816079630057442.v14);
create or replace view aggJoin6311477318816020170 as (
with aggView8120046196591348677 as (select id as v18 from keyword as k)
select v36, v48, v49 from aggJoin1788118798740762139 join aggView8120046196591348677 using(v18));
create or replace view aggJoin6318207852564210076 as (
with aggView7305688828710873707 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin7864100912621910639 join aggView7305688828710873707 using(v7));
create or replace view aggJoin5966580461171624889 as (
with aggView625013657505208468 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView625013657505208468 where cc.status_id=aggView625013657505208468.v5);
create or replace view aggJoin7289358059892365387 as (
with aggView7229291293269033492 as (select v36 from aggJoin5966580461171624889 group by v36)
select v36, v31, v32 from aggJoin333935838451157857 join aggView7229291293269033492 using(v36));
create or replace view aggJoin7822620353244157919 as (
with aggView5429046914536479824 as (select v36 from aggJoin7289358059892365387 group by v36)
select v36 from aggJoin6318207852564210076 join aggView5429046914536479824 using(v36));
create or replace view aggJoin6283205154334804208 as (
with aggView3416254134414393503 as (select v36 from aggJoin7822620353244157919 group by v36)
select v48 as v48, v49 as v49 from aggJoin6311477318816020170 join aggView3416254134414393503 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin6283205154334804208;
