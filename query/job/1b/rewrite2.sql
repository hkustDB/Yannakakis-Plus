create or replace view aggView4331408775248150521 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin8820997261350872266 as select movie_id as v15 from movie_info_idx as mi_idx, aggView4331408775248150521 where mi_idx.info_type_id=aggView4331408775248150521.v3;
create or replace view aggView7216897259657524669 as select v15 from aggJoin8820997261350872266 group by v15;
create or replace view aggJoin3708128535885036624 as select id as v15, title as v16, production_year as v19 from title as t, aggView7216897259657524669 where t.id=aggView7216897259657524669.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView6639496611952337866 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin3708128535885036624 group by v15;
create or replace view aggJoin241379572649894080 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6639496611952337866 where mc.movie_id=aggView6639496611952337866.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8499263223721812343 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin129830597952627747 as select v9, v28, v29 from aggJoin241379572649894080 join aggView8499263223721812343 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin129830597952627747;
