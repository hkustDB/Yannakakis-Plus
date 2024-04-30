create or replace view aggView3093962843340231138 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5224779820084072917 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3093962843340231138 where mc.company_type_id=aggView3093962843340231138.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView6117312752441640264 as select v15, MIN(v9) as v27 from aggJoin5224779820084072917 group by v15;
create or replace view aggJoin1200338935984981503 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView6117312752441640264 where t.id=aggView6117312752441640264.v15;
create or replace view aggView8492019567083337546 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin6784282364979211114 as select movie_id as v15 from movie_info_idx as mi_idx, aggView8492019567083337546 where mi_idx.info_type_id=aggView8492019567083337546.v3;
create or replace view aggView9037534684550997080 as select v15 from aggJoin6784282364979211114 group by v15;
create or replace view aggJoin2795728220635692287 as select v16, v19, v27 as v27 from aggJoin1200338935984981503 join aggView9037534684550997080 using(v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin2795728220635692287;
