create or replace view aggView2299495051266890838 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin474251858611895646 as select movie_id as v23, v36 from cast_info as ci, aggView2299495051266890838 where ci.person_id=aggView2299495051266890838.v14;
create or replace view aggView8401889086168814782 as select v23, MIN(v36) as v36 from aggJoin474251858611895646 group by v23;
create or replace view aggJoin6048018636130454354 as select id as v23, title as v24, v36 from title as t, aggView8401889086168814782 where t.id=aggView8401889086168814782.v23 and production_year>2014;
create or replace view aggView2207023795292210162 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin6048018636130454354 group by v23;
create or replace view aggJoin9012332220507194970 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView2207023795292210162 where mk.movie_id=aggView2207023795292210162.v23;
create or replace view aggView3595901561913727579 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin9012332220507194970 group by v8;
create or replace view aggJoin4203789854259628122 as select keyword as v9, v36, v37 from keyword as k, aggView3595901561913727579 where k.id=aggView3595901561913727579.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4203789854259628122;
