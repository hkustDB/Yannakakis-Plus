create or replace view aggView3341858683281620468 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin3053141044552911912 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3341858683281620468 where mi_idx.info_type_id=aggView3341858683281620468.v3;
create or replace view aggView2783139018147451679 as select v15 from aggJoin3053141044552911912 group by v15;
create or replace view aggJoin6404422246669994133 as select id as v15, title as v16, production_year as v19 from title as t, aggView2783139018147451679 where t.id=aggView2783139018147451679.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView5591174284959521951 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin6404422246669994133 group by v15;
create or replace view aggJoin1353033584244137822 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView5591174284959521951 where mc.movie_id=aggView5591174284959521951.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8616626943986236564 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3051820504572736883 as select v9, v28, v29 from aggJoin1353033584244137822 join aggView8616626943986236564 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3051820504572736883;
