create or replace view aggView790637958786002051 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin8744087234608563378 as select movie_id as v23, v35 from movie_keyword as mk, aggView790637958786002051 where mk.keyword_id=aggView790637958786002051.v8;
create or replace view aggView5411467682267623296 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin723723737110007574 as select movie_id as v23, v36 from cast_info as ci, aggView5411467682267623296 where ci.person_id=aggView5411467682267623296.v14;
create or replace view aggView2928019304189124712 as select v23, MIN(v35) as v35 from aggJoin8744087234608563378 group by v23;
create or replace view aggJoin7192067156691097331 as select id as v23, title as v24, v35 from title as t, aggView2928019304189124712 where t.id=aggView2928019304189124712.v23 and production_year>2000;
create or replace view aggView6343058941804501028 as select v23, MIN(v36) as v36 from aggJoin723723737110007574 group by v23;
create or replace view aggJoin1976982699387890541 as select v24, v35 as v35, v36 from aggJoin7192067156691097331 join aggView6343058941804501028 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin1976982699387890541;
