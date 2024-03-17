create or replace view aggView8330607612333700501 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4923327061231508327 as select movie_id as v23, v35 from movie_keyword as mk, aggView8330607612333700501 where mk.keyword_id=aggView8330607612333700501.v8;
create or replace view aggView28212770390766305 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1099311000567022662 as select movie_id as v23, v36 from cast_info as ci, aggView28212770390766305 where ci.person_id=aggView28212770390766305.v14;
create or replace view aggView3488183698119143233 as select v23, MIN(v35) as v35 from aggJoin4923327061231508327 group by v23;
create or replace view aggJoin4297488398025383533 as select id as v23, title as v24, v35 from title as t, aggView3488183698119143233 where t.id=aggView3488183698119143233.v23 and production_year>2000;
create or replace view aggView3675309489344738000 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin4297488398025383533 group by v23;
create or replace view aggJoin6003916836076354367 as select v36 as v36, v35, v37 from aggJoin1099311000567022662 join aggView3675309489344738000 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6003916836076354367;
