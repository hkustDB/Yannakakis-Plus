create or replace view aggView2625436895070694769 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin7478918287605931370 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView2625436895070694769 where mk.movie_id=aggView2625436895070694769.v23;
create or replace view aggView4927893781144728333 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8418083250924842560 as select movie_id as v23, v36 from cast_info as ci, aggView4927893781144728333 where ci.person_id=aggView4927893781144728333.v14;
create or replace view aggView2469993902370284786 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin6121953113109185773 as select v23, v37, v35 from aggJoin7478918287605931370 join aggView2469993902370284786 using(v8);
create or replace view aggView1520135889606815128 as select v23, MIN(v36) as v36 from aggJoin8418083250924842560 group by v23;
create or replace view aggJoin3425252886016553532 as select v37 as v37, v35 as v35, v36 from aggJoin6121953113109185773 join aggView1520135889606815128 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3425252886016553532;
