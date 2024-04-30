create or replace view aggView8863665185581495185 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin4865604725648435441 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView8863665185581495185 where mc.movie_id=aggView8863665185581495185.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView798112189186356988 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin7714284663132073300 as select movie_id as v15 from movie_info_idx as mi_idx, aggView798112189186356988 where mi_idx.info_type_id=aggView798112189186356988.v3;
create or replace view aggView9033795950448547904 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3410741189511335549 as select v15, v9, v28, v29 from aggJoin4865604725648435441 join aggView9033795950448547904 using(v1);
create or replace view aggView7272012108178755390 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin3410741189511335549 group by v15;
create or replace view aggJoin7597309525187109717 as select v28, v29, v27 from aggJoin7714284663132073300 join aggView7272012108178755390 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7597309525187109717;
