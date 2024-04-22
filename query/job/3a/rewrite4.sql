create or replace view aggJoin2618009478080388519 as (
with aggView4065874854658463636 as (select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select id as v12, title as v13, production_year as v16 from title as t, aggView4065874854658463636 where t.id=aggView4065874854658463636.v12 and production_year>2005);
create or replace view aggJoin5318216253096321563 as (
with aggView3800479730296011101 as (select v12, MIN(v13) as v24 from aggJoin2618009478080388519 group by v12)
select keyword_id as v1, v24 from movie_keyword as mk, aggView3800479730296011101 where mk.movie_id=aggView3800479730296011101.v12);
create or replace view aggJoin8337692216342990871 as (
with aggView4838735660316235642 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select v24 from aggJoin5318216253096321563 join aggView4838735660316235642 using(v1));
select MIN(v24) as v24 from aggJoin8337692216342990871;
