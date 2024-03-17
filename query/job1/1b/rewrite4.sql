create or replace view aggView4927175760340802037 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin9118782655951590262 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView4927175760340802037 where mi_idx.movie_id=aggView4927175760340802037.v15;
create or replace view aggView5668874189676539001 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2878571795050594230 as select v15, v28, v29 from aggJoin9118782655951590262 join aggView5668874189676539001 using(v3);
create or replace view aggView4735145038707987750 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin2878571795050594230 group by v15;
create or replace view aggJoin2880147787489566367 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView4735145038707987750 where mc.movie_id=aggView4735145038707987750.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView2922768863833441107 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4722015797133690148 as select v9, v28, v29 from aggJoin2880147787489566367 join aggView2922768863833441107 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4722015797133690148;
