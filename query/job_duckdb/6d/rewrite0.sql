create or replace view aggView3106523680045372903 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8089691257340946481 as select movie_id as v23, v36 from cast_info as ci, aggView3106523680045372903 where ci.person_id=aggView3106523680045372903.v14;
create or replace view aggView7800388340386305671 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin4149621726294789018 as select movie_id as v23, v35 from movie_keyword as mk, aggView7800388340386305671 where mk.keyword_id=aggView7800388340386305671.v8;
create or replace view aggView5926219926683524559 as select v23, MIN(v35) as v35 from aggJoin4149621726294789018 group by v23;
create or replace view aggJoin444708884624486133 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView5926219926683524559 where t.id=aggView5926219926683524559.v23 and production_year>2000;
create or replace view aggView4484496229723211262 as select v23, MIN(v36) as v36 from aggJoin8089691257340946481 group by v23;
create or replace view aggJoin2411836476076793986 as select v24, v27, v35 as v35, v36 from aggJoin444708884624486133 join aggView4484496229723211262 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin2411836476076793986;
