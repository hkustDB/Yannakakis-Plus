create or replace view aggView4520075734631118330 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7083256070517430581 as select movie_id as v23, v36 from cast_info as ci, aggView4520075734631118330 where ci.person_id=aggView4520075734631118330.v14;
create or replace view aggView3701607218944769193 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5455063761298417560 as select movie_id as v23, v35 from movie_keyword as mk, aggView3701607218944769193 where mk.keyword_id=aggView3701607218944769193.v8;
create or replace view aggView899809518891192812 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin7971884534109842841 as select v23, v35, v37 from aggJoin5455063761298417560 join aggView899809518891192812 using(v23);
create or replace view aggView6996435574138685578 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin7971884534109842841 group by v23;
create or replace view aggJoin1266515451293082490 as select v36 as v36, v35, v37 from aggJoin7083256070517430581 join aggView6996435574138685578 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1266515451293082490;
