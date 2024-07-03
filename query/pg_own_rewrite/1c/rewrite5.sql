create or replace view aggView5268683473283890216 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3628959276793710186 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5268683473283890216 where mc.company_type_id=aggView5268683473283890216.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView542324004093573687 as select v15, MIN(v9) as v27 from aggJoin3628959276793710186 group by v15;
create or replace view aggJoin388286118455970127 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView542324004093573687 where t.id=aggView542324004093573687.v15 and production_year>2010;
create or replace view aggView8967053360028383886 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin388286118455970127 group by v15,v27;
create or replace view aggJoin4679022397299922369 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView8967053360028383886 where mi_idx.movie_id=aggView8967053360028383886.v15;
create or replace view aggView4346108880056823680 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin2340385178018264998 as select v27, v28, v29 from aggJoin4679022397299922369 join aggView4346108880056823680 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2340385178018264998;
