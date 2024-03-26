create or replace view aggView2461416104295798710 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5533916167653605123 as select movie_id as v14 from movie_keyword as mk, aggView2461416104295798710 where mk.keyword_id=aggView2461416104295798710.v3;
create or replace view aggView2529629616647079091 as select v14 from aggJoin5533916167653605123 group by v14;
create or replace view aggJoin118775316561382661 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx as mi_idx, aggView2529629616647079091 where mi_idx.movie_id=aggView2529629616647079091.v14 and info>'2.0';
create or replace view aggView8823990714636201018 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin772275039353376093 as select v14, v9 from aggJoin118775316561382661 join aggView8823990714636201018 using(v1);
create or replace view aggView5247069939347652916 as select v14, MIN(v9) as v26 from aggJoin772275039353376093 group by v14;
create or replace view aggJoin342455166359840874 as select title as v15, v26 from title as t, aggView5247069939347652916 where t.id=aggView5247069939347652916.v14 and production_year>1990;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin342455166359840874;
