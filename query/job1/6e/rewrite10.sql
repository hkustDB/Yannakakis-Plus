create or replace view aggView725600512344604834 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin1776965637118431033 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView725600512344604834 where mk.movie_id=aggView725600512344604834.v23;
create or replace view aggView5081482117391317432 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin6356734333826964656 as select v23, v37, v35 from aggJoin1776965637118431033 join aggView5081482117391317432 using(v8);
create or replace view aggView6645625382005233465 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin6356734333826964656 group by v23;
create or replace view aggJoin775164894743853820 as select person_id as v14, v37, v35 from cast_info as ci, aggView6645625382005233465 where ci.movie_id=aggView6645625382005233465.v23;
create or replace view aggView6304696257361215898 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin775164894743853820 group by v14;
create or replace view aggJoin257951704163733543 as select name as v15, v37, v35 from name as n, aggView6304696257361215898 where n.id=aggView6304696257361215898.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin257951704163733543;
