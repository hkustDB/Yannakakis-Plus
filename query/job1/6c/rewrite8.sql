create or replace view aggView8730128675550256731 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin358666722081447924 as select movie_id as v23, v35 from movie_keyword as mk, aggView8730128675550256731 where mk.keyword_id=aggView8730128675550256731.v8;
create or replace view aggView4290463550233368380 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8412914671906481698 as select movie_id as v23, v36 from cast_info as ci, aggView4290463550233368380 where ci.person_id=aggView4290463550233368380.v14;
create or replace view aggView8235935401004642744 as select v23, MIN(v35) as v35 from aggJoin358666722081447924 group by v23;
create or replace view aggJoin6635598986708453794 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView8235935401004642744 where t.id=aggView8235935401004642744.v23 and production_year>2014;
create or replace view aggView858693239069216154 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin6635598986708453794 group by v23;
create or replace view aggJoin8861532164485273370 as select v36 as v36, v35, v37 from aggJoin8412914671906481698 join aggView858693239069216154 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8861532164485273370;
