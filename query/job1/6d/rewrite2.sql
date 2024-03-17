create or replace view aggView6881139808307389996 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6297873092541572672 as select movie_id as v23, v36 from cast_info as ci, aggView6881139808307389996 where ci.person_id=aggView6881139808307389996.v14;
create or replace view aggView2328130396846635282 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin7633485689918219054 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView2328130396846635282 where mk.movie_id=aggView2328130396846635282.v23;
create or replace view aggView4313135726066255415 as select v23, MIN(v36) as v36 from aggJoin6297873092541572672 group by v23;
create or replace view aggJoin794624892010227345 as select v8, v37 as v37, v36 from aggJoin7633485689918219054 join aggView4313135726066255415 using(v23);
create or replace view aggView5477206063983286434 as select v8, MIN(v37) as v37, MIN(v36) as v36 from aggJoin794624892010227345 group by v8;
create or replace view aggJoin2974048656682369406 as select keyword as v9, v37, v36 from keyword as k, aggView5477206063983286434 where k.id=aggView5477206063983286434.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2974048656682369406;
