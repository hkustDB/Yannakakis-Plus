create or replace view aggView6385686414538478526 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7778688413834331606 as select movie_id as v23, v35 from movie_keyword as mk, aggView6385686414538478526 where mk.keyword_id=aggView6385686414538478526.v8;
create or replace view aggView5514923292766387419 as select v23, MIN(v35) as v35 from aggJoin7778688413834331606 group by v23;
create or replace view aggJoin8757975037052176875 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView5514923292766387419 where t.id=aggView5514923292766387419.v23 and production_year>2014;
create or replace view aggView8071392460492227371 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin8757975037052176875 group by v23;
create or replace view aggJoin4155119015021895870 as select person_id as v14, v35, v37 from cast_info as ci, aggView8071392460492227371 where ci.movie_id=aggView8071392460492227371.v23;
create or replace view aggView549080631699733887 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin4155119015021895870 group by v14;
create or replace view aggJoin395958102835230778 as select name as v15, v35, v37 from name as n, aggView549080631699733887 where n.id=aggView549080631699733887.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin395958102835230778;
