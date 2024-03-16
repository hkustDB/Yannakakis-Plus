create or replace view aggView4856646119933335515 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8518393702857212842 as select movie_id as v12 from movie_keyword as mk, aggView4856646119933335515 where mk.keyword_id=aggView4856646119933335515.v1;
create or replace view aggView5080541669643318824 as select v12 from aggJoin8518393702857212842 group by v12;
create or replace view aggJoin8227205301862537479 as select id as v12, title as v13 from title as t, aggView5080541669643318824 where t.id=aggView5080541669643318824.v12 and production_year>2010;
create or replace view aggView6030020413383922836 as select v12, MIN(v13) as v24 from aggJoin8227205301862537479 group by v12;
create or replace view aggJoin8670277018656416762 as select v24 from movie_info as mi, aggView6030020413383922836 where mi.movie_id=aggView6030020413383922836.v12 and info= 'Bulgaria';
select MIN(v24) as v24 from aggJoin8670277018656416762;
