create or replace view aggView2485874731112156728 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin4756893471992565216 as select movie_id as v15 from movie_info_idx as mi_idx, aggView2485874731112156728 where mi_idx.info_type_id=aggView2485874731112156728.v3;
create or replace view aggView2364644311261232224 as select v15 from aggJoin4756893471992565216 group by v15;
create or replace view aggJoin1282348055490521359 as select id as v15, title as v16, production_year as v19 from title as t, aggView2364644311261232224 where t.id=aggView2364644311261232224.v15 and production_year>2010;
create or replace view aggView6093147712864959484 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin1282348055490521359 group by v15;
create or replace view aggJoin466323693236965787 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6093147712864959484 where mc.movie_id=aggView6093147712864959484.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1932708398675265667 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4733706416787554264 as select v9, v28, v29 from aggJoin466323693236965787 join aggView1932708398675265667 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4733706416787554264;
