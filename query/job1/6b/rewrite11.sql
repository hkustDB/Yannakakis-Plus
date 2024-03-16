create or replace view aggView5646105784173989490 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin5623716842851679227 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView5646105784173989490 where ci.movie_id=aggView5646105784173989490.v23;
create or replace view aggView6128584318630506653 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7802705074965240238 as select v23, v37 from aggJoin5623716842851679227 join aggView6128584318630506653 using(v14);
create or replace view aggView6193972397647113640 as select v23, MIN(v37) as v37 from aggJoin7802705074965240238 group by v23;
create or replace view aggJoin5823782764661925626 as select keyword_id as v8, v37 from movie_keyword as mk, aggView6193972397647113640 where mk.movie_id=aggView6193972397647113640.v23;
create or replace view aggView3727423885390904959 as select v8, MIN(v37) as v37 from aggJoin5823782764661925626 group by v8;
create or replace view aggJoin4169072196293675931 as select keyword as v9, v37 from keyword as k, aggView3727423885390904959 where k.id=aggView3727423885390904959.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4169072196293675931;
