create or replace view aggView5949951291537601267 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin711629013768989615 as select movie_id as v23, v35 from movie_keyword as mk, aggView5949951291537601267 where mk.keyword_id=aggView5949951291537601267.v8;
create or replace view aggView5978574229597403192 as select v23, MIN(v35) as v35 from aggJoin711629013768989615 group by v23;
create or replace view aggJoin4060633428328768405 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView5978574229597403192 where t.id=aggView5978574229597403192.v23 and production_year>2014;
create or replace view aggView6124646593595705692 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin4060633428328768405 group by v23;
create or replace view aggJoin8614600854429284289 as select person_id as v14, v35, v37 from cast_info as ci, aggView6124646593595705692 where ci.movie_id=aggView6124646593595705692.v23;
create or replace view aggView7041974312997401681 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin8614600854429284289 group by v14;
create or replace view aggJoin3194865886729687543 as select name as v15, v35, v37 from name as n, aggView7041974312997401681 where n.id=aggView7041974312997401681.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin3194865886729687543;
