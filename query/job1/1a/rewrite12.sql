create or replace view aggView5829531459392617546 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin874883777854183805 as select movie_id as v15 from movie_info_idx as mi_idx, aggView5829531459392617546 where mi_idx.info_type_id=aggView5829531459392617546.v3;
create or replace view aggView1517814046876361908 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin9012987898077026037 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1517814046876361908 where mc.company_type_id=aggView1517814046876361908.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView3970112686133492363 as select v15, MIN(v9) as v27 from aggJoin9012987898077026037 group by v15;
create or replace view aggJoin8543989504781081608 as select v15, v27 from aggJoin874883777854183805 join aggView3970112686133492363 using(v15);
create or replace view aggView4687253222393073049 as select v15, MIN(v27) as v27 from aggJoin8543989504781081608 group by v15;
create or replace view aggJoin1097707958318549328 as select title as v16, production_year as v19, v27 from title as t, aggView4687253222393073049 where t.id=aggView4687253222393073049.v15;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin1097707958318549328;
