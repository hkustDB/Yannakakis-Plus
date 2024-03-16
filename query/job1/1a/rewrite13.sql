create or replace view aggView606789445871978635 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin2006372148356811254 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView606789445871978635 where mi_idx.movie_id=aggView606789445871978635.v15;
create or replace view aggView688121979114792510 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin791135097583685409 as select v15, v28, v29 from aggJoin2006372148356811254 join aggView688121979114792510 using(v3);
create or replace view aggView5880523309655776378 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4883523538809908486 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5880523309655776378 where mc.company_type_id=aggView5880523309655776378.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView6789788049951140697 as select v15, MIN(v9) as v27 from aggJoin4883523538809908486 group by v15;
create or replace view aggJoin5378732563591197209 as select v28 as v28, v29 as v29, v27 from aggJoin791135097583685409 join aggView6789788049951140697 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5378732563591197209;
