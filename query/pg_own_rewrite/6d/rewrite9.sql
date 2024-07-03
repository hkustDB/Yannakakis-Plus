create or replace view aggView8124706397743812503 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin8978338362132781355 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView8124706397743812503 where mk.movie_id=aggView8124706397743812503.v23;
create or replace view aggView2708203014585931458 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3315188839317319802 as select v23, v37, v35 from aggJoin8978338362132781355 join aggView2708203014585931458 using(v8);
create or replace view aggView1045753495717906924 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin3315188839317319802 group by v23,v35,v37;
create or replace view aggJoin7158669774662206524 as select person_id as v14, v37, v35 from cast_info as ci, aggView1045753495717906924 where ci.movie_id=aggView1045753495717906924.v23;
create or replace view aggView7119094071109642902 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5291903711780117424 as select v37, v35, v36 from aggJoin7158669774662206524 join aggView7119094071109642902 using(v14);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5291903711780117424;
