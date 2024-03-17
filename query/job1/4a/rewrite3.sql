create or replace view aggView3052666012759799990 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2981895793131124165 as select movie_id as v14 from movie_keyword as mk, aggView3052666012759799990 where mk.keyword_id=aggView3052666012759799990.v3;
create or replace view aggView6085116895006362396 as select v14 from aggJoin2981895793131124165 group by v14;
create or replace view aggJoin5943895479307934808 as select id as v14, title as v15 from title as t, aggView6085116895006362396 where t.id=aggView6085116895006362396.v14 and production_year>2005;
create or replace view aggView5938245805951164209 as select v14, MIN(v15) as v27 from aggJoin5943895479307934808 group by v14;
create or replace view aggJoin6141752173871212686 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView5938245805951164209 where mi_idx.movie_id=aggView5938245805951164209.v14 and info>'5.0';
create or replace view aggView5602688601909258903 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6090072750732087453 as select v9, v27 from aggJoin6141752173871212686 join aggView5602688601909258903 using(v1);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin6090072750732087453;
