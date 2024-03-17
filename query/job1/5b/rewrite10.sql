create or replace view aggView9020140656638780468 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin7423305310623742510 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView9020140656638780468 where mc.movie_id=aggView9020140656638780468.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView4663331472049893663 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6377015325432535221 as select v15, v9, v27 from aggJoin7423305310623742510 join aggView4663331472049893663 using(v1);
create or replace view aggView569816295157477605 as select v15, MIN(v27) as v27 from aggJoin6377015325432535221 group by v15;
create or replace view aggJoin8576299836311516773 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView569816295157477605 where mi.movie_id=aggView569816295157477605.v15 and info IN ('USA','America');
create or replace view aggView3592816291972194847 as select id as v3 from info_type as it;
create or replace view aggJoin7723009918820926529 as select v13, v27 from aggJoin8576299836311516773 join aggView3592816291972194847 using(v3);
select MIN(v27) as v27 from aggJoin7723009918820926529;
