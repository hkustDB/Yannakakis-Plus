create or replace view aggView594186083004509122 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin8969798335415941195 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView594186083004509122 where mi_idx.movie_id=aggView594186083004509122.v14 and info>'2.0';
create or replace view aggView3003982878699235580 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1214048202906478971 as select movie_id as v14 from movie_keyword as mk, aggView3003982878699235580 where mk.keyword_id=aggView3003982878699235580.v3;
create or replace view aggView4891374536035112532 as select v14 from aggJoin1214048202906478971 group by v14;
create or replace view aggJoin2619338455613512899 as select v1, v9, v27 as v27 from aggJoin8969798335415941195 join aggView4891374536035112532 using(v14);
create or replace view aggView2540667626319501707 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3821327830241120005 as select v9, v27 from aggJoin2619338455613512899 join aggView2540667626319501707 using(v1);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin3821327830241120005;
