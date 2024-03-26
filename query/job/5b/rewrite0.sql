create or replace view aggView8551483275704293102 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin891462098088139785 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8551483275704293102 where mc.company_type_id=aggView8551483275704293102.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView3510937604087687620 as select v15 from aggJoin891462098088139785 group by v15;
create or replace view aggJoin9104422450073736706 as select id as v15, title as v16 from title as t, aggView3510937604087687620 where t.id=aggView3510937604087687620.v15 and production_year>2010;
create or replace view aggView3800809387928887603 as select v15, MIN(v16) as v27 from aggJoin9104422450073736706 group by v15;
create or replace view aggJoin4981794426663861548 as select info_type_id as v3, v27 from movie_info as mi, aggView3800809387928887603 where mi.movie_id=aggView3800809387928887603.v15 and info IN ('USA','America');
create or replace view aggView4575728444548571606 as select v3, MIN(v27) as v27 from aggJoin4981794426663861548 group by v3;
create or replace view aggJoin5603542574390432737 as select v27 from info_type as it, aggView4575728444548571606 where it.id=aggView4575728444548571606.v3;
select MIN(v27) as v27 from aggJoin5603542574390432737;
