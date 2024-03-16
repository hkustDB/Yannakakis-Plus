create or replace view aggView4070873507494591380 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2341780514283426639 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4070873507494591380 where mc.company_type_id=aggView4070873507494591380.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView2990438238124549919 as select v15, MIN(v9) as v27 from aggJoin2341780514283426639 group by v15;
create or replace view aggJoin5439784397732636912 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView2990438238124549919 where t.id=aggView2990438238124549919.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView6560771916252311355 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin5439784397732636912 group by v15;
create or replace view aggJoin7202464402349334911 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView6560771916252311355 where mi_idx.movie_id=aggView6560771916252311355.v15;
create or replace view aggView4924706756835441322 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin3851981639743022544 as select v27, v28, v29 from aggJoin7202464402349334911 join aggView4924706756835441322 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3851981639743022544;
