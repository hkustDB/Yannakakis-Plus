create or replace view aggJoin4317113909519409599 as (
with aggView2762864210866783730 as (select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id)
select id as v12, title as v13, production_year as v16 from title as t, aggView2762864210866783730 where t.id=aggView2762864210866783730.v12 and production_year>1990);
create or replace view aggJoin5848195370409064870 as (
with aggView7963455503164216288 as (select v12, MIN(v13) as v24 from aggJoin4317113909519409599 group by v12)
select keyword_id as v1, v24 from movie_keyword as mk, aggView7963455503164216288 where mk.movie_id=aggView7963455503164216288.v12);
create or replace view aggJoin493164509167634889 as (
with aggView1060052130627467820 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select v24 from aggJoin5848195370409064870 join aggView1060052130627467820 using(v1));
select MIN(v24) as v24 from aggJoin493164509167634889;
