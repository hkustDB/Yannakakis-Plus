create or replace view aggView3828172165529789843 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6124731262511207113 as select movie_id as v23, v36 from cast_info as ci, aggView3828172165529789843 where ci.person_id=aggView3828172165529789843.v14;
create or replace view aggView2854598016196663291 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin6499406712740386727 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView2854598016196663291 where mk.movie_id=aggView2854598016196663291.v23;
create or replace view aggView956016570748952426 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3453342239834241222 as select v23, v37 from aggJoin6499406712740386727 join aggView956016570748952426 using(v8);
create or replace view aggView4349900111434551778 as select v23, MIN(v36) as v36 from aggJoin6124731262511207113 group by v23;
create or replace view aggJoin8068038624167910162 as select v37 as v37, v36 from aggJoin3453342239834241222 join aggView4349900111434551778 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8068038624167910162;
