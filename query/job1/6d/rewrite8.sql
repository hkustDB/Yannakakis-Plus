create or replace view aggView5119962057631841248 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin216195929328131425 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView5119962057631841248 where ci.movie_id=aggView5119962057631841248.v23;
create or replace view aggView9006057720485309399 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin36030002167675013 as select v23, v37 from aggJoin216195929328131425 join aggView9006057720485309399 using(v14);
create or replace view aggView3617755651156592104 as select v23, MIN(v37) as v37 from aggJoin36030002167675013 group by v23;
create or replace view aggJoin8532622693394371051 as select keyword_id as v8, v37 from movie_keyword as mk, aggView3617755651156592104 where mk.movie_id=aggView3617755651156592104.v23;
create or replace view aggView7386518751813254242 as select v8, MIN(v37) as v37 from aggJoin8532622693394371051 group by v8;
create or replace view aggJoin1432236182313181529 as select keyword as v9, v37 from keyword as k, aggView7386518751813254242 where k.id=aggView7386518751813254242.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1432236182313181529;
