create or replace view aggView3431661630245399531 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin7213309295924109745 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3431661630245399531 where mi_idx.info_type_id=aggView3431661630245399531.v1 and info>'5.0';
create or replace view aggView4111195928531509567 as select v14, MIN(v9) as v26 from aggJoin7213309295924109745 group by v14;
create or replace view aggJoin4294139271985187327 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView4111195928531509567 where t.id=aggView4111195928531509567.v14 and production_year>2005;
create or replace view aggView6331365510328870995 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin4294139271985187327 group by v14;
create or replace view aggJoin2070867368361076149 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView6331365510328870995 where mk.movie_id=aggView6331365510328870995.v14;
create or replace view aggView8507805428792372762 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8009339312586641786 as select v26, v27 from aggJoin2070867368361076149 join aggView8507805428792372762 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8009339312586641786;
