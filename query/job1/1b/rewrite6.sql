create or replace view aggView1175738015657267249 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin4216547530147579632 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1175738015657267249 where mi_idx.info_type_id=aggView1175738015657267249.v3;
create or replace view aggView5824520474209110425 as select v15 from aggJoin4216547530147579632 group by v15;
create or replace view aggJoin377112042179419956 as select id as v15, title as v16, production_year as v19 from title as t, aggView5824520474209110425 where t.id=aggView5824520474209110425.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView6936975724743411641 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin377112042179419956 group by v15;
create or replace view aggJoin5234917842629612091 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6936975724743411641 where mc.movie_id=aggView6936975724743411641.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3331833682142550087 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8869190920405910696 as select v9, v28, v29 from aggJoin5234917842629612091 join aggView3331833682142550087 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8869190920405910696;
