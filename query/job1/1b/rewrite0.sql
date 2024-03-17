create or replace view aggView8589976412323417113 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin1988981267384211641 as select movie_id as v15 from movie_info_idx as mi_idx, aggView8589976412323417113 where mi_idx.info_type_id=aggView8589976412323417113.v3;
create or replace view aggView6923469728832606503 as select v15 from aggJoin1988981267384211641 group by v15;
create or replace view aggJoin2348045741615364468 as select id as v15, title as v16, production_year as v19 from title as t, aggView6923469728832606503 where t.id=aggView6923469728832606503.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView2925851521861425276 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin2348045741615364468 group by v15;
create or replace view aggJoin2733940666951607204 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView2925851521861425276 where mc.movie_id=aggView2925851521861425276.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView6788214891665848046 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin2733940666951607204 group by v1;
create or replace view aggJoin5715959943644958315 as select v28, v29, v27 from company_type as ct, aggView6788214891665848046 where ct.id=aggView6788214891665848046.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5715959943644958315;
