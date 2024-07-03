create or replace view aggView6005649432752252312 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin6107087667223956403 as select movie_id as v23, v35 from movie_keyword as mk, aggView6005649432752252312 where mk.keyword_id=aggView6005649432752252312.v8;
create or replace view aggView1508430536781174612 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin2462864569046849836 as select v23, v35, v37 from aggJoin6107087667223956403 join aggView1508430536781174612 using(v23);
create or replace view aggView6472006661641173691 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3267671548196453546 as select movie_id as v23, v36 from cast_info as ci, aggView6472006661641173691 where ci.person_id=aggView6472006661641173691.v14;
create or replace view aggView670114729545944549 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin2462864569046849836 group by v23,v35,v37;
create or replace view aggJoin8535221744213364000 as select v36 as v36, v35, v37 from aggJoin3267671548196453546 join aggView670114729545944549 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8535221744213364000;
