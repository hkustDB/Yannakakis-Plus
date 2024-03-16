create or replace view aggView2317441004638779112 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin7059694576932911430 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView2317441004638779112 where mi_idx.movie_id=aggView2317441004638779112.v15;
create or replace view aggView5528305189584909359 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5026202238934417271 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5528305189584909359 where mc.company_type_id=aggView5528305189584909359.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1448998454574034506 as select v15, MIN(v9) as v27 from aggJoin5026202238934417271 group by v15;
create or replace view aggJoin9009243593436467902 as select v3, v28 as v28, v29 as v29, v27 from aggJoin7059694576932911430 join aggView1448998454574034506 using(v15);
create or replace view aggView3178769306520940785 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin9009243593436467902 group by v3;
create or replace view aggJoin1807893491298316622 as select info as v4, v28, v29, v27 from info_type as it, aggView3178769306520940785 where it.id=aggView3178769306520940785.v3 and info= 'bottom 10 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1807893491298316622;
