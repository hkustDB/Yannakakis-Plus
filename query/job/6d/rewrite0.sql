create or replace view aggView5696814793038954515 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5023742407314833333 as select movie_id as v23, v36 from cast_info as ci, aggView5696814793038954515 where ci.person_id=aggView5696814793038954515.v14;
create or replace view aggView8006183752288449402 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1280115702900901463 as select movie_id as v23, v35 from movie_keyword as mk, aggView8006183752288449402 where mk.keyword_id=aggView8006183752288449402.v8;
create or replace view aggView732301299224457690 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin4581281895065053515 as select v23, v35, v37 from aggJoin1280115702900901463 join aggView732301299224457690 using(v23);
create or replace view aggView8097959443983710515 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin4581281895065053515 group by v23;
create or replace view aggJoin7864808921008813899 as select v36 as v36, v35, v37 from aggJoin5023742407314833333 join aggView8097959443983710515 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7864808921008813899;
