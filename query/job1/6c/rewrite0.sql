create or replace view aggView2891143784411981028 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1062717615460464209 as select movie_id as v23, v35 from movie_keyword as mk, aggView2891143784411981028 where mk.keyword_id=aggView2891143784411981028.v8;
create or replace view aggView947648812601490277 as select v23, MIN(v35) as v35 from aggJoin1062717615460464209 group by v23;
create or replace view aggJoin5425824554775286843 as select id as v23, title as v24, v35 from title as t, aggView947648812601490277 where t.id=aggView947648812601490277.v23 and production_year>2014;
create or replace view aggView8548735456056312124 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin5425824554775286843 group by v23;
create or replace view aggJoin8757779039753528932 as select person_id as v14, v35, v37 from cast_info as ci, aggView8548735456056312124 where ci.movie_id=aggView8548735456056312124.v23;
create or replace view aggView8818125203323991460 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin8757779039753528932 group by v14;
create or replace view aggJoin4591316058690295390 as select name as v15, v35, v37 from name as n, aggView8818125203323991460 where n.id=aggView8818125203323991460.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin4591316058690295390;
