create or replace view aggView3476041115773926917 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin7255547517425362528 as select movie_id as v23, v35 from movie_keyword as mk, aggView3476041115773926917 where mk.keyword_id=aggView3476041115773926917.v8;
create or replace view aggView8158149004953591527 as select v23, MIN(v35) as v35 from aggJoin7255547517425362528 group by v23;
create or replace view aggJoin8935144670959983201 as select id as v23, title as v24, v35 from title as t, aggView8158149004953591527 where t.id=aggView8158149004953591527.v23 and production_year>2000;
create or replace view aggView6099297244505276571 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin8935144670959983201 group by v23;
create or replace view aggJoin6929224288354216600 as select person_id as v14, v35, v37 from cast_info as ci, aggView6099297244505276571 where ci.movie_id=aggView6099297244505276571.v23;
create or replace view aggView6106232891944163371 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin6929224288354216600 group by v14;
create or replace view aggJoin4301052468707985068 as select name as v15, v35, v37 from name as n, aggView6106232891944163371 where n.id=aggView6106232891944163371.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin4301052468707985068;
