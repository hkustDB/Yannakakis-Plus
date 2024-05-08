create or replace view aggView5316001860507277182 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2928193397652831951 as select movie_id as v15 from movie_info_idx as mi_idx, aggView5316001860507277182 where mi_idx.info_type_id=aggView5316001860507277182.v3;
create or replace view aggView2223051349543867001 as select v15 from aggJoin2928193397652831951 group by v15;
create or replace view aggJoin696259189689154352 as select id as v15, title as v16, production_year as v19 from title as t, aggView2223051349543867001 where t.id=aggView2223051349543867001.v15 and production_year>2000;
create or replace view aggView2381851843530911220 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8520131496031052376 as select movie_id as v15, note as v9 from movie_companies as mc, aggView2381851843530911220 where mc.company_type_id=aggView2381851843530911220.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3684278228333972192 as select v15, MIN(v9) as v27 from aggJoin8520131496031052376 group by v15;
create or replace view aggJoin1161868764673550085 as select v16, v19, v27 from aggJoin696259189689154352 join aggView3684278228333972192 using(v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin1161868764673550085;
