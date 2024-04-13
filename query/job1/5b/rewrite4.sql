create or replace view aggView4261059229963003732 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin5455966119672625350 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView4261059229963003732 where mc.movie_id=aggView4261059229963003732.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView509623111146033676 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4471939119939937100 as select v15, v9, v27 from aggJoin5455966119672625350 join aggView509623111146033676 using(v1);
create or replace view aggView266534870245299652 as select v15, MIN(v27) as v27 from aggJoin4471939119939937100 group by v15,v27;
create or replace view aggJoin8566720709340711252 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView266534870245299652 where mi.movie_id=aggView266534870245299652.v15 and info IN ('USA','America');
create or replace view aggView4219801510883872002 as select id as v3 from info_type as it;
create or replace view aggJoin215139651341387963 as select v27 from aggJoin8566720709340711252 join aggView4219801510883872002 using(v3);
select MIN(v27) as v27 from aggJoin215139651341387963;
