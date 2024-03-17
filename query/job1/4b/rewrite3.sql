create or replace view aggView2917613350482897983 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1212874856209080075 as select movie_id as v14 from movie_keyword as mk, aggView2917613350482897983 where mk.keyword_id=aggView2917613350482897983.v3;
create or replace view aggView1614802980456696803 as select v14 from aggJoin1212874856209080075 group by v14;
create or replace view aggJoin1876785871215689200 as select id as v14, title as v15 from title as t, aggView1614802980456696803 where t.id=aggView1614802980456696803.v14 and production_year>2010;
create or replace view aggView8679740499988300585 as select v14, MIN(v15) as v27 from aggJoin1876785871215689200 group by v14;
create or replace view aggJoin3175592083245781779 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView8679740499988300585 where mi_idx.movie_id=aggView8679740499988300585.v14 and info>'9.0';
create or replace view aggView5247004896177845912 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1210289924067503486 as select v9, v27 from aggJoin3175592083245781779 join aggView5247004896177845912 using(v1);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin1210289924067503486;
