create or replace view aggView3348014192093297096 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6677883766992869742 as select movie_id as v23, v36 from cast_info as ci, aggView3348014192093297096 where ci.person_id=aggView3348014192093297096.v14;
create or replace view aggView2476728626912855264 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin1374926341941667023 as select v23, v36 from aggJoin6677883766992869742 join aggView2476728626912855264 using(v23);
create or replace view aggView5031766505507815705 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3426416066792127411 as select movie_id as v23, v35 from movie_keyword as mk, aggView5031766505507815705 where mk.keyword_id=aggView5031766505507815705.v8;
create or replace view aggView8176494411712454756 as select v23, MIN(v35) as v35 from aggJoin3426416066792127411 group by v23;
create or replace view aggJoin571399468042648149 as select v36 as v36, v35 from aggJoin1374926341941667023 join aggView8176494411712454756 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin571399468042648149;
