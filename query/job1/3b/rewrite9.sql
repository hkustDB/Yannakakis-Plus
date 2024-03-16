create or replace view aggView7416115273579208304 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin5880043917188725898 as select id as v12, title as v13 from title as t, aggView7416115273579208304 where t.id=aggView7416115273579208304.v12 and production_year>2010;
create or replace view aggView1285018789528062836 as select v12, MIN(v13) as v24 from aggJoin5880043917188725898 group by v12;
create or replace view aggJoin1162944450628060282 as select keyword_id as v1, v24 from movie_keyword as mk, aggView1285018789528062836 where mk.movie_id=aggView1285018789528062836.v12;
create or replace view aggView7328011402020549669 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5645196962659685783 as select v24 from aggJoin1162944450628060282 join aggView7328011402020549669 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin5645196962659685783;
select sum(v24) from res;