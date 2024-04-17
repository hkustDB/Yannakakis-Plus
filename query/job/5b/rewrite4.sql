create or replace view aggView8390164651563863024 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin5542123255936017013 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView8390164651563863024 where mc.movie_id=aggView8390164651563863024.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView7914127766064477495 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3792690191298892114 as select v15, v9, v27 from aggJoin5542123255936017013 join aggView7914127766064477495 using(v1);
create or replace view aggView3733046584405110401 as select v15, MIN(v27) as v27 from aggJoin3792690191298892114 group by v15,v27;
create or replace view aggJoin6537339139244555915 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView3733046584405110401 where mi.movie_id=aggView3733046584405110401.v15 and info IN ('USA','America');
create or replace view aggView870863680023343889 as select id as v3 from info_type as it;
create or replace view aggJoin7242791746977764408 as select v27 from aggJoin6537339139244555915 join aggView870863680023343889 using(v3);
select MIN(v27) as v27 from aggJoin7242791746977764408;
