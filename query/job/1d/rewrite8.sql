create or replace view aggView686982832461214799 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin7985710091501332319 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView686982832461214799 where mi_idx.movie_id=aggView686982832461214799.v15;
create or replace view aggView6974999379398375827 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin7119844956062962550 as select v15, v28, v29 from aggJoin7985710091501332319 join aggView6974999379398375827 using(v3);
create or replace view aggView7074981108883681323 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin7119844956062962550 group by v15,v29,v28;
create or replace view aggJoin683402279380235633 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView7074981108883681323 where mc.movie_id=aggView7074981108883681323.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView143686436858211948 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2921102307236386091 as select v9, v28, v29 from aggJoin683402279380235633 join aggView143686436858211948 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2921102307236386091;
