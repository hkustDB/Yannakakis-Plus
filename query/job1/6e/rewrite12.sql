create or replace view aggView1186526715848165181 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin1456658675700657101 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView1186526715848165181 where ci.movie_id=aggView1186526715848165181.v23;
create or replace view aggView4720015501100971643 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4617953802011085916 as select movie_id as v23, v35 from movie_keyword as mk, aggView4720015501100971643 where mk.keyword_id=aggView4720015501100971643.v8;
create or replace view aggView3904094122044024466 as select v23, MIN(v35) as v35 from aggJoin4617953802011085916 group by v23;
create or replace view aggJoin4271579181383713867 as select v14, v37 as v37, v35 from aggJoin1456658675700657101 join aggView3904094122044024466 using(v23);
create or replace view aggView6716102899742649090 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin4271579181383713867 group by v14;
create or replace view aggJoin3581769680858845596 as select name as v15, v37, v35 from name as n, aggView6716102899742649090 where n.id=aggView6716102899742649090.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin3581769680858845596;
