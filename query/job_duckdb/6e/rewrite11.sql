create or replace view aggView8765989759594529464 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1118803754044143130 as select movie_id as v23, v35 from movie_keyword as mk, aggView8765989759594529464 where mk.keyword_id=aggView8765989759594529464.v8;
create or replace view aggView8327437451464525669 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6571133819334196769 as select movie_id as v23, v36 from cast_info as ci, aggView8327437451464525669 where ci.person_id=aggView8327437451464525669.v14;
create or replace view aggView2880848708956434184 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin5664719294904324320 as select v23, v36, v37 from aggJoin6571133819334196769 join aggView2880848708956434184 using(v23);
create or replace view aggView8075392891458586080 as select v23, MIN(v35) as v35 from aggJoin1118803754044143130 group by v23,v35;
create or replace view aggJoin8012841313024158483 as select v36 as v36, v37 as v37, v35 from aggJoin5664719294904324320 join aggView8075392891458586080 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8012841313024158483;
