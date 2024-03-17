create or replace view aggView4401350298635898555 as select id as v3 from info_type as it;
create or replace view aggJoin6564818384006742690 as select movie_id as v15, info as v13 from movie_info as mi, aggView4401350298635898555 where mi.info_type_id=aggView4401350298635898555.v3 and info IN ('USA','America');
create or replace view aggView272864456889630338 as select v15 from aggJoin6564818384006742690 group by v15;
create or replace view aggJoin2024357587427225782 as select id as v15, title as v16 from title as t, aggView272864456889630338 where t.id=aggView272864456889630338.v15 and production_year>2010;
create or replace view aggView7734516644628450146 as select v15, MIN(v16) as v27 from aggJoin2024357587427225782 group by v15;
create or replace view aggJoin4637910311413096176 as select company_type_id as v1, v27 from movie_companies as mc, aggView7734516644628450146 where mc.movie_id=aggView7734516644628450146.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView3512145120610087312 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6053264993327460031 as select v27 from aggJoin4637910311413096176 join aggView3512145120610087312 using(v1);
select MIN(v27) as v27 from aggJoin6053264993327460031;
