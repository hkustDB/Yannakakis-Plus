create or replace view aggView8387371842546616865 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin506335641656422490 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView8387371842546616865 where mk.movie_id=aggView8387371842546616865.v12;
create or replace view aggView1486983218008784272 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin8519751901517517156 as select v1, v24 as v24 from aggJoin506335641656422490 join aggView1486983218008784272 using(v12);
create or replace view aggView463327341623015403 as select v1, MIN(v24) as v24 from aggJoin8519751901517517156 group by v1;
create or replace view aggJoin2956373591834156068 as select keyword as v2, v24 from keyword as k, aggView463327341623015403 where k.id=aggView463327341623015403.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin2956373591834156068;
select sum(v24) from res;