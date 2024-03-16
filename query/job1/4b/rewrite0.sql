create or replace view aggView5888335090495539405 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4293741420355423626 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView5888335090495539405 where mi_idx.info_type_id=aggView5888335090495539405.v1 and info>'9.0';
create or replace view aggView7503118515482123039 as select v14, MIN(v9) as v26 from aggJoin4293741420355423626 group by v14;
create or replace view aggJoin5317907212867336313 as select id as v14, title as v15, v26 from title as t, aggView7503118515482123039 where t.id=aggView7503118515482123039.v14 and production_year>2010;
create or replace view aggView8179361141276768061 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin5317907212867336313 group by v14;
create or replace view aggJoin2267390801693121375 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView8179361141276768061 where mk.movie_id=aggView8179361141276768061.v14;
create or replace view aggView8623491355908894759 as select v3, MIN(v26) as v26, MIN(v27) as v27 from aggJoin2267390801693121375 group by v3;
create or replace view aggJoin3383756802250835298 as select v26, v27 from keyword as k, aggView8623491355908894759 where k.id=aggView8623491355908894759.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3383756802250835298;
