create or replace view aggView8355738265934244706 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin6190523735737260583 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView8355738265934244706 where mi.movie_id=aggView8355738265934244706.v15 and info IN ('USA','America');
create or replace view aggView4217146358487388278 as select id as v3 from info_type as it;
create or replace view aggJoin720490019055731838 as select v15, v13, v27 from aggJoin6190523735737260583 join aggView4217146358487388278 using(v3);
create or replace view aggView4987613915872425628 as select v15, MIN(v27) as v27 from aggJoin720490019055731838 group by v15;
create or replace view aggJoin116185521665191808 as select company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView4987613915872425628 where mc.movie_id=aggView4987613915872425628.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView9167558613310418406 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4695010958250429707 as select v9, v27 from aggJoin116185521665191808 join aggView9167558613310418406 using(v1);
select MIN(v27) as v27 from aggJoin4695010958250429707;
