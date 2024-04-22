create or replace view aggJoin7366215477147388837 as (
with aggView6949842512344477388 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v12 from movie_keyword as mk, aggView6949842512344477388 where mk.keyword_id=aggView6949842512344477388.v1);
create or replace view aggJoin7616806438579703516 as (
with aggView479722472667778856 as (select v12 from aggJoin7366215477147388837 group by v12)
select id as v12, title as v13, production_year as v16 from title as t, aggView479722472667778856 where t.id=aggView479722472667778856.v12 and production_year>1990);
create or replace view aggJoin6806451766347116781 as (
with aggView3107897083771603325 as (select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id)
select v13, v16 from aggJoin7616806438579703516 join aggView3107897083771603325 using(v12));
create or replace view aggView7388097087141092795 as select v13 from aggJoin6806451766347116781 group by v13;
select MIN(v13) as v24 from aggView7388097087141092795;
