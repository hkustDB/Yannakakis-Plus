create or replace view aggView5502136278296247822 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin1769915180109956666 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView5502136278296247822 where mi_idx.movie_id=aggView5502136278296247822.v15;
create or replace view aggView945123427931420280 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin996553287253679030 as select v15, v28, v29 from aggJoin1769915180109956666 join aggView945123427931420280 using(v3);
create or replace view aggView1783573573301295441 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin996553287253679030 group by v15;
create or replace view aggJoin2220030279595254 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView1783573573301295441 where mc.movie_id=aggView1783573573301295441.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4586656490203854071 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin195180789435067102 as select v9, v28, v29 from aggJoin2220030279595254 join aggView4586656490203854071 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin195180789435067102;
