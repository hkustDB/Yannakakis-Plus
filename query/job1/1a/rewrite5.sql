create or replace view aggView1913435472735129043 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5641427974836745204 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1913435472735129043 where mc.company_type_id=aggView1913435472735129043.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView8806323298625539668 as select v15, MIN(v9) as v27 from aggJoin5641427974836745204 group by v15;
create or replace view aggJoin7295412394401573919 as select movie_id as v15, info_type_id as v3, v27 from movie_info_idx as mi_idx, aggView8806323298625539668 where mi_idx.movie_id=aggView8806323298625539668.v15;
create or replace view aggView836341132754908309 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin27774627448432229 as select v15, v27 from aggJoin7295412394401573919 join aggView836341132754908309 using(v3);
create or replace view aggView6307450442662836247 as select v15, MIN(v27) as v27 from aggJoin27774627448432229 group by v15;
create or replace view aggJoin1012882593191149705 as select title as v16, production_year as v19, v27 from title as t, aggView6307450442662836247 where t.id=aggView6307450442662836247.v15;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin1012882593191149705;
