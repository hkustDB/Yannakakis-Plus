create or replace view aggView4910069836484207839 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin4973644733513621245 as select movie_id as v15 from movie_info_idx as mi_idx, aggView4910069836484207839 where mi_idx.info_type_id=aggView4910069836484207839.v3;
create or replace view aggView8207919352664663120 as select v15 from aggJoin4973644733513621245 group by v15;
create or replace view aggJoin2453075225973918892 as select id as v15, title as v16, production_year as v19 from title as t, aggView8207919352664663120 where t.id=aggView8207919352664663120.v15 and production_year>2010;
create or replace view aggView5921400004922115954 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin2453075225973918892 group by v15;
create or replace view aggJoin2450977182242377816 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView5921400004922115954 where mc.movie_id=aggView5921400004922115954.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3743459631818180264 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2906589353752084982 as select v9, v28, v29 from aggJoin2450977182242377816 join aggView3743459631818180264 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2906589353752084982;
