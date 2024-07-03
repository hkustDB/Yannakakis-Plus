create or replace view aggView2637105388045524503 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin488195493246270076 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView2637105388045524503 where mi.movie_id=aggView2637105388045524503.v12 and info= 'Bulgaria';
create or replace view aggView3025441585085505157 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3527975482167904482 as select movie_id as v12 from movie_keyword as mk, aggView3025441585085505157 where mk.keyword_id=aggView3025441585085505157.v1;
create or replace view aggView2126520850503825425 as select v12, MIN(v24) as v24 from aggJoin488195493246270076 group by v12,v24;
create or replace view aggJoin277256583754879549 as select v24 from aggJoin3527975482167904482 join aggView2126520850503825425 using(v12);
select MIN(v24) as v24 from aggJoin277256583754879549;
