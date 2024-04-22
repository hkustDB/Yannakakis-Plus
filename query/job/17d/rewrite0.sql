create or replace view aggJoin9151054635785430344 as (
with aggView1396167038435019922 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView1396167038435019922 where mc.company_id=aggView1396167038435019922.v20);
create or replace view aggJoin5129973701035000447 as (
with aggView8122696515124664576 as (select v3 from aggJoin9151054635785430344 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView8122696515124664576 where ci.movie_id=aggView8122696515124664576.v3);
create or replace view aggJoin1692961683148502270 as (
with aggView8762547045939020636 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8762547045939020636 where mk.keyword_id=aggView8762547045939020636.v25);
create or replace view aggJoin5812555392068008623 as (
with aggView8099076219415788620 as (select v3 from aggJoin1692961683148502270 group by v3)
select id as v3 from title as t, aggView8099076219415788620 where t.id=aggView8099076219415788620.v3);
create or replace view aggJoin2536633987989117485 as (
with aggView3804076032011650748 as (select v3 from aggJoin5812555392068008623 group by v3)
select v26 from aggJoin5129973701035000447 join aggView3804076032011650748 using(v3));
create or replace view aggJoin1048086893438295869 as (
with aggView8369051074993319511 as (select v26 from aggJoin2536633987989117485 group by v26)
select name as v27 from name as n, aggView8369051074993319511 where n.id=aggView8369051074993319511.v26);
create or replace view aggJoin3799966127498304218 as (
with aggView4380467417363184566 as (select v27 from aggJoin1048086893438295869 group by v27)
select v27 from aggView4380467417363184566 where v27 LIKE '%Bert%');
select MIN(v27) as v47 from aggJoin3799966127498304218;
