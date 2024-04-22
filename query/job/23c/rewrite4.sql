create or replace view aggJoin8940583794493636855 as (
with aggView123327269127479806 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView123327269127479806 where mi.info_type_id=aggView123327269127479806.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin157487716430977150 as (
with aggView4056300472688175138 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView4056300472688175138 where mk.keyword_id=aggView4056300472688175138.v18);
create or replace view aggJoin5641830254772880431 as (
with aggView5597998751051282770 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView5597998751051282770 where mc.company_type_id=aggView5597998751051282770.v14);
create or replace view aggJoin6937790840966558599 as (
with aggView3428146996611391729 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin5641830254772880431 join aggView3428146996611391729 using(v7));
create or replace view aggJoin7857337902065000481 as (
with aggView3941674215135834802 as (select v36 from aggJoin157487716430977150 group by v36)
select v36, v31, v32 from aggJoin8940583794493636855 join aggView3941674215135834802 using(v36));
create or replace view aggJoin5081059105958964306 as (
with aggView1131686268942020050 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView1131686268942020050 where cc.status_id=aggView1131686268942020050.v5);
create or replace view aggJoin1674773301989748913 as (
with aggView7058528890632581083 as (select v36 from aggJoin5081059105958964306 group by v36)
select v36, v31, v32 from aggJoin7857337902065000481 join aggView7058528890632581083 using(v36));
create or replace view aggJoin7018461516481700418 as (
with aggView7262455544537683087 as (select v36 from aggJoin6937790840966558599 group by v36)
select id as v36, title as v37, kind_id as v21, production_year as v40 from title as t, aggView7262455544537683087 where t.id=aggView7262455544537683087.v36 and production_year>1990);
create or replace view aggJoin1789796433587759500 as (
with aggView7086209617842198069 as (select v36 from aggJoin1674773301989748913 group by v36)
select v37, v21, v40 from aggJoin7018461516481700418 join aggView7086209617842198069 using(v36));
create or replace view aggView7301935195501516888 as select v37, v21 from aggJoin1789796433587759500 group by v37,v21;
create or replace view aggJoin1982030413157585914 as (
with aggView4662988004435484909 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select v37, v48 from aggView7301935195501516888 join aggView4662988004435484909 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin1982030413157585914;
