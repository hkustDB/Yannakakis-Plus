create or replace view aggView744379165915488429 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin2200585275890612603 as select movie_id as v15 from movie_info_idx as mi_idx, aggView744379165915488429 where mi_idx.info_type_id=aggView744379165915488429.v3;
create or replace view aggView5429897494889247951 as select v15 from aggJoin2200585275890612603 group by v15;
create or replace view aggJoin3346077759131399293 as select id as v15, title as v16, production_year as v19 from title as t, aggView5429897494889247951 where t.id=aggView5429897494889247951.v15;
create or replace view aggView5641335433519437993 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin3346077759131399293 group by v15;
create or replace view aggJoin103346309041373417 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView5641335433519437993 where mc.movie_id=aggView5641335433519437993.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView4952405395472012352 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4757462173452349524 as select v9, v28, v29 from aggJoin103346309041373417 join aggView4952405395472012352 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4757462173452349524;
