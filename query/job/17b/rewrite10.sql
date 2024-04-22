create or replace view aggJoin3518809025314164391 as (
with aggView4031286641451047843 as (select id as v26, name as v47 from name as n where name LIKE 'Z%')
select movie_id as v3, v47 from cast_info as ci, aggView4031286641451047843 where ci.person_id=aggView4031286641451047843.v26);
create or replace view aggJoin5767912078526192410 as (
with aggView8493695604384144007 as (select id as v3 from title as t)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView8493695604384144007 where mk.movie_id=aggView8493695604384144007.v3);
create or replace view aggJoin7438552253672967283 as (
with aggView8253995458920822539 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView8253995458920822539 where mc.company_id=aggView8253995458920822539.v20);
create or replace view aggJoin6737423226198704564 as (
with aggView8716504007836941997 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin5767912078526192410 join aggView8716504007836941997 using(v25));
create or replace view aggJoin918729797367908421 as (
with aggView2150726329286375713 as (select v3 from aggJoin6737423226198704564 group by v3)
select v3 from aggJoin7438552253672967283 join aggView2150726329286375713 using(v3));
create or replace view aggJoin2387218545639548113 as (
with aggView880318588726192552 as (select v3 from aggJoin918729797367908421 group by v3)
select v47 as v47 from aggJoin3518809025314164391 join aggView880318588726192552 using(v3));
select MIN(v47) as v47 from aggJoin2387218545639548113;
