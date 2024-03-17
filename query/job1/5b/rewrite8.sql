create or replace view aggView2995435621192154980 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin2703944435630891875 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView2995435621192154980 where mi.movie_id=aggView2995435621192154980.v15 and info IN ('USA','America');
create or replace view aggView732551855644146560 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2825516575790257752 as select movie_id as v15, note as v9 from movie_companies as mc, aggView732551855644146560 where mc.company_type_id=aggView732551855644146560.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView3532450997875570074 as select v15 from aggJoin2825516575790257752 group by v15;
create or replace view aggJoin2071659500195664360 as select v3, v13, v27 as v27 from aggJoin2703944435630891875 join aggView3532450997875570074 using(v15);
create or replace view aggView6535007271851241136 as select v3, MIN(v27) as v27 from aggJoin2071659500195664360 group by v3;
create or replace view aggJoin6286819003333088288 as select v27 from info_type as it, aggView6535007271851241136 where it.id=aggView6535007271851241136.v3;
select MIN(v27) as v27 from aggJoin6286819003333088288;
