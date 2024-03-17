create or replace view aggView7927934766812014303 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2576970350827621613 as select movie_id as v23, v36 from cast_info as ci, aggView7927934766812014303 where ci.person_id=aggView7927934766812014303.v14;
create or replace view aggView6386019843118911819 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7946230358714642128 as select movie_id as v23, v35 from movie_keyword as mk, aggView6386019843118911819 where mk.keyword_id=aggView6386019843118911819.v8;
create or replace view aggView3329872346264086862 as select v23, MIN(v36) as v36 from aggJoin2576970350827621613 group by v23;
create or replace view aggJoin7226220517914150233 as select v23, v35 as v35, v36 from aggJoin7946230358714642128 join aggView3329872346264086862 using(v23);
create or replace view aggView3274367816014670867 as select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin7226220517914150233 group by v23;
create or replace view aggJoin7948351540367211184 as select title as v24, v35, v36 from title as t, aggView3274367816014670867 where t.id=aggView3274367816014670867.v23 and production_year>2010;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin7948351540367211184;
