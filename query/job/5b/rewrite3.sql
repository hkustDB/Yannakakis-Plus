create or replace view aggView8389162978967312796 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin4009776323005750914 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView8389162978967312796 where mc.movie_id=aggView8389162978967312796.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView2933047564399750421 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2979511939135978357 as select v15, v9, v27 from aggJoin4009776323005750914 join aggView2933047564399750421 using(v1);
create or replace view aggView1845252475008854376 as select v15, MIN(v27) as v27 from aggJoin2979511939135978357 group by v15;
create or replace view aggJoin5171383590584844600 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView1845252475008854376 where mi.movie_id=aggView1845252475008854376.v15 and info IN ('USA','America');
create or replace view aggView8906753915639393858 as select id as v3 from info_type as it;
create or replace view aggJoin6597100367952200151 as select v27 from aggJoin5171383590584844600 join aggView8906753915639393858 using(v3);
select MIN(v27) as v27 from aggJoin6597100367952200151;
