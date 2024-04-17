create or replace view aggView156349889919120189 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin2337420622808231899 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView156349889919120189 where mi_idx.movie_id=aggView156349889919120189.v14 and info>'5.0';
create or replace view aggView1048872984730031732 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1085228034890015406 as select v14, v9, v27 from aggJoin2337420622808231899 join aggView1048872984730031732 using(v1);
create or replace view aggView2812179213240906735 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin1085228034890015406 group by v14,v27;
create or replace view aggJoin1342398353275384689 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView2812179213240906735 where mk.movie_id=aggView2812179213240906735.v14;
create or replace view aggView5957359483715079763 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6758395705155564391 as select v27, v26 from aggJoin1342398353275384689 join aggView5957359483715079763 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin6758395705155564391;
