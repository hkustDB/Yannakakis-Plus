create or replace view aggView4010113484766126580 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin7738023883339878594 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView4010113484766126580 where mk.movie_id=aggView4010113484766126580.v12;
create or replace view aggView1679268078446912277 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2903691267692702576 as select v12 from aggJoin7738023883339878594 join aggView1679268078446912277 using(v1);
create or replace view aggView4890078277398233330 as select v12 from aggJoin2903691267692702576 group by v12;
create or replace view aggJoin221387470126951016 as select title as v13 from title as t, aggView4890078277398233330 where t.id=aggView4890078277398233330.v12 and production_year>2010;
create or replace view res as select MIN(v13) as v24 from aggJoin221387470126951016;
select sum(v24) from res;