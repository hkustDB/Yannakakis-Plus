create or replace view aggView8871191828809841204 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3130653996011693564 as select movie_id as v23, v35 from movie_keyword as mk, aggView8871191828809841204 where mk.keyword_id=aggView8871191828809841204.v8;
create or replace view aggView3022057455611203307 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin2749047082251123132 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView3022057455611203307 where ci.movie_id=aggView3022057455611203307.v23;
create or replace view aggView2672062216822041748 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4981306346118144636 as select v23, v37, v36 from aggJoin2749047082251123132 join aggView2672062216822041748 using(v14);
create or replace view aggView6263629454572349233 as select v23, MIN(v35) as v35 from aggJoin3130653996011693564 group by v23,v35;
create or replace view aggJoin1193886029990719934 as select v37 as v37, v36 as v36, v35 from aggJoin4981306346118144636 join aggView6263629454572349233 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1193886029990719934;
