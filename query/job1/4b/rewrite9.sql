create or replace view aggView4529924765931146719 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5992561445301920140 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4529924765931146719 where mi_idx.info_type_id=aggView4529924765931146719.v1 and info>'9.0';
create or replace view aggView6118998224833092893 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2161404260326596028 as select movie_id as v14 from movie_keyword as mk, aggView6118998224833092893 where mk.keyword_id=aggView6118998224833092893.v3;
create or replace view aggView3202126989561294485 as select v14 from aggJoin2161404260326596028 group by v14;
create or replace view aggJoin6406629553414342031 as select v14, v9 from aggJoin5992561445301920140 join aggView3202126989561294485 using(v14);
create or replace view aggView3173498067091801804 as select v14, MIN(v9) as v26 from aggJoin6406629553414342031 group by v14;
create or replace view aggJoin9188809761805458574 as select title as v15, v26 from title as t, aggView3173498067091801804 where t.id=aggView3173498067091801804.v14 and production_year>2010;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin9188809761805458574;
