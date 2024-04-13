create or replace view aggView3810419928789893960 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin495038562989258407 as select movie_id as v23, v35 from movie_keyword as mk, aggView3810419928789893960 where mk.keyword_id=aggView3810419928789893960.v8;
create or replace view aggView116987125682701215 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin115110994617825039 as select v23, v35, v37 from aggJoin495038562989258407 join aggView116987125682701215 using(v23);
create or replace view aggView296880002551673540 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5847923181753399142 as select movie_id as v23, v36 from cast_info as ci, aggView296880002551673540 where ci.person_id=aggView296880002551673540.v14;
create or replace view aggView4014991497407654859 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin115110994617825039 group by v23,v35,v37;
create or replace view aggJoin1369304366168424527 as select v36 as v36, v35, v37 from aggJoin5847923181753399142 join aggView4014991497407654859 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1369304366168424527;
