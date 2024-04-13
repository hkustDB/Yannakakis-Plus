create or replace view aggView7155941820904145630 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5345206075339236967 as select movie_id as v23, v36 from cast_info as ci, aggView7155941820904145630 where ci.person_id=aggView7155941820904145630.v14;
create or replace view aggView5866208590499139735 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin955921760450086238 as select v23, v36, v37 from aggJoin5345206075339236967 join aggView5866208590499139735 using(v23);
create or replace view aggView1492317708705455653 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4819054821084459070 as select movie_id as v23, v35 from movie_keyword as mk, aggView1492317708705455653 where mk.keyword_id=aggView1492317708705455653.v8;
create or replace view aggView7762871099723840325 as select v23, MIN(v35) as v35 from aggJoin4819054821084459070 group by v23,v35;
create or replace view aggJoin830293294413208497 as select v36 as v36, v37 as v37, v35 from aggJoin955921760450086238 join aggView7762871099723840325 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin830293294413208497;
