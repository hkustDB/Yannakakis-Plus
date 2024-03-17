create or replace view aggView8827527596802308895 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin3752765693959297334 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView8827527596802308895 where mk.movie_id=aggView8827527596802308895.v14;
create or replace view aggView8296435740799017906 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1092307725328747558 as select v14, v27 from aggJoin3752765693959297334 join aggView8296435740799017906 using(v3);
create or replace view aggView159717649766624987 as select v14, MIN(v27) as v27 from aggJoin1092307725328747558 group by v14;
create or replace view aggJoin7029076973021178516 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView159717649766624987 where mi_idx.movie_id=aggView159717649766624987.v14 and info>'5.0';
create or replace view aggView209457816392499658 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin7029076973021178516 group by v1;
create or replace view aggJoin2979175701856557105 as select v27, v26 from info_type as it, aggView209457816392499658 where it.id=aggView209457816392499658.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2979175701856557105;
