create or replace view aggView2630194412140258364 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin3922989126465398742 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView2630194412140258364 where mk.movie_id=aggView2630194412140258364.v12;
create or replace view aggView1947598862031434369 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1002046271428062740 as select v12, v24 from aggJoin3922989126465398742 join aggView1947598862031434369 using(v1);
create or replace view aggView8637732122418460011 as select v12, MIN(v24) as v24 from aggJoin1002046271428062740 group by v12;
create or replace view aggJoin2474277049635155180 as select info as v7, v24 from movie_info as mi, aggView8637732122418460011 where mi.movie_id=aggView8637732122418460011.v12 and info= 'Bulgaria';
select MIN(v24) as v24 from aggJoin2474277049635155180;
