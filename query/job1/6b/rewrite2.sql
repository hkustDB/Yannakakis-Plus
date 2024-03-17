create or replace view aggView4983686432195707517 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin420110233792072750 as select movie_id as v23, v35 from movie_keyword as mk, aggView4983686432195707517 where mk.keyword_id=aggView4983686432195707517.v8;
create or replace view aggView1439223707825963528 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin821991823370678720 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView1439223707825963528 where ci.movie_id=aggView1439223707825963528.v23;
create or replace view aggView7797963001790578746 as select v23, MIN(v35) as v35 from aggJoin420110233792072750 group by v23;
create or replace view aggJoin7423928630842876673 as select v14, v37 as v37, v35 from aggJoin821991823370678720 join aggView7797963001790578746 using(v23);
create or replace view aggView3764866783097681742 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin7423928630842876673 group by v14;
create or replace view aggJoin5327934483478285449 as select name as v15, v37, v35 from name as n, aggView3764866783097681742 where n.id=aggView3764866783097681742.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin5327934483478285449;
