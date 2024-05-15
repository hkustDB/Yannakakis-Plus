create or replace view aggView9095635087333913968 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4800409020338933214 as select movie_id as v12 from movie_keyword as mk, aggView9095635087333913968 where mk.keyword_id=aggView9095635087333913968.v1;
create or replace view aggView5552808702446415576 as select v12 from aggJoin4800409020338933214 group by v12;
create or replace view aggJoin2045669345603159412 as select movie_id as v12, info as v7 from movie_info as mi, aggView5552808702446415576 where mi.movie_id=aggView5552808702446415576.v12 and info= 'Bulgaria';
create or replace view aggView6357413508005373834 as select v12 from aggJoin2045669345603159412 group by v12;
create or replace view aggJoin5621021369781805171 as select title as v13, production_year as v16 from title as t, aggView6357413508005373834 where t.id=aggView6357413508005373834.v12 and production_year>2010;
create or replace view aggView5736258984368901455 as select v13 from aggJoin5621021369781805171;
select MIN(v13) as v24 from aggView5736258984368901455;
