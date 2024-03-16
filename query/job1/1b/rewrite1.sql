create or replace view aggView8005686208739458163 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8698646839739234638 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8005686208739458163 where mc.company_type_id=aggView8005686208739458163.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1234702089852087796 as select v15, MIN(v9) as v27 from aggJoin8698646839739234638 group by v15;
create or replace view aggJoin5545237039786595001 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView1234702089852087796 where t.id=aggView1234702089852087796.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView6432006274819335944 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin5545237039786595001 group by v15;
create or replace view aggJoin124731673276097684 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView6432006274819335944 where mi_idx.movie_id=aggView6432006274819335944.v15;
create or replace view aggView5224591595373629828 as select v3, MIN(v27) as v27, MIN(v28) as v28, MIN(v29) as v29 from aggJoin124731673276097684 group by v3;
create or replace view aggJoin7431884114499166908 as select v27, v28, v29 from info_type as it, aggView5224591595373629828 where it.id=aggView5224591595373629828.v3 and info= 'bottom 10 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7431884114499166908;
