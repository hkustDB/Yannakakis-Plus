create or replace view aggView6768714694571772489 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7079840765781256831 as select movie_id as v23, v36 from cast_info as ci, aggView6768714694571772489 where ci.person_id=aggView6768714694571772489.v14;
create or replace view aggView4657669026579661624 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin1376499403828078564 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView4657669026579661624 where mk.movie_id=aggView4657669026579661624.v23;
create or replace view aggView804745147954260199 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7895937152577960369 as select v23, v37, v35 from aggJoin1376499403828078564 join aggView804745147954260199 using(v8);
create or replace view aggView623783091933460734 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin7895937152577960369 group by v23,v37,v35;
create or replace view aggJoin4904152657111349128 as select v36 as v36, v37, v35 from aggJoin7079840765781256831 join aggView623783091933460734 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4904152657111349128;
