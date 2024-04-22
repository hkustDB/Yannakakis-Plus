create or replace view aggJoin6036817610612622498 as (
with aggView5805325983136853047 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView5805325983136853047 where mi_idx.info_type_id=aggView5805325983136853047.v1 and info>'9.0');
create or replace view aggView1968604009277930124 as select v9, v14 from aggJoin6036817610612622498 group by v9,v14;
create or replace view aggJoin9077439114593425690 as (
with aggView4067020987428384502 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView4067020987428384502 where mk.keyword_id=aggView4067020987428384502.v3);
create or replace view aggJoin4790731890307890570 as (
with aggView4887596710957043051 as (select v14 from aggJoin9077439114593425690 group by v14)
select id as v14, title as v15, production_year as v18 from title as t, aggView4887596710957043051 where t.id=aggView4887596710957043051.v14 and production_year>2010);
create or replace view aggView8032784139485649183 as select v15, v14 from aggJoin4790731890307890570 group by v15,v14;
create or replace view aggJoin1343897847140339472 as (
with aggView1806179161256990547 as (select v14, MIN(v9) as v26 from aggView1968604009277930124 group by v14)
select v15, v26 from aggView8032784139485649183 join aggView1806179161256990547 using(v14));
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin1343897847140339472;
