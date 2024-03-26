create or replace view aggView3437228688168858802 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6956259041601671807 as select movie_id as v12 from movie_keyword as mk, aggView3437228688168858802 where mk.keyword_id=aggView3437228688168858802.v1;
create or replace view aggView1976729413572727186 as select v12 from aggJoin6956259041601671807 group by v12;
create or replace view aggJoin6704707094036547562 as select movie_id as v12, info as v7 from movie_info as mi, aggView1976729413572727186 where mi.movie_id=aggView1976729413572727186.v12 and info= 'Bulgaria';
create or replace view aggView4735216821319543687 as select v12 from aggJoin6704707094036547562 group by v12;
create or replace view aggJoin8746972973476332060 as select title as v13 from title as t, aggView4735216821319543687 where t.id=aggView4735216821319543687.v12 and production_year>2010;
select MIN(v13) as v24 from aggJoin8746972973476332060;
