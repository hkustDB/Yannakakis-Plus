create or replace view aggJoin5113012982665098911 as (
with aggView2470720209724101901 as (select id as v12, title as v24 from title as t where production_year>2005)
select movie_id as v12, info as v7, v24 from movie_info as mi, aggView2470720209724101901 where mi.movie_id=aggView2470720209724101901.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin6117084773420688704 as (
with aggView69147266862768972 as (select v12, MIN(v24) as v24 from aggJoin5113012982665098911 group by v12,v24)
select keyword_id as v1, v24 from movie_keyword as mk, aggView69147266862768972 where mk.movie_id=aggView69147266862768972.v12);
create or replace view aggJoin4957790379330950906 as (
with aggView3488493916437850819 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select v24 from aggJoin6117084773420688704 join aggView3488493916437850819 using(v1));
select MIN(v24) as v24 from aggJoin4957790379330950906;
