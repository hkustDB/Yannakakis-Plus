create or replace view aggView8591099437741089512 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin6119354327817128737 as select movie_id as v23, v35 from movie_keyword as mk, aggView8591099437741089512 where mk.keyword_id=aggView8591099437741089512.v8;
create or replace view aggView6556743117107052519 as select v23, MIN(v35) as v35 from aggJoin6119354327817128737 group by v23,v35;
create or replace view aggJoin7609078352307709966 as select person_id as v14, movie_id as v23, v35 from cast_info as ci, aggView6556743117107052519 where ci.movie_id=aggView6556743117107052519.v23;
create or replace view aggView3810542118365839366 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin4023324020263809214 as select v14, v35, v37 from aggJoin7609078352307709966 join aggView3810542118365839366 using(v23);
create or replace view aggView6569354571227241307 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3793463710328021091 as select v35, v37, v36 from aggJoin4023324020263809214 join aggView6569354571227241307 using(v14);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3793463710328021091;
