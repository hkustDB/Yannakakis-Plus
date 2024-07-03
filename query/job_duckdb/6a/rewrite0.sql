create or replace view aggView3277031739411515180 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7424453920291085915 as select movie_id as v23, v36 from cast_info as ci, aggView3277031739411515180 where ci.person_id=aggView3277031739411515180.v14;
create or replace view aggView3154358457888557569 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7188679808528422131 as select movie_id as v23, v35 from movie_keyword as mk, aggView3154358457888557569 where mk.keyword_id=aggView3154358457888557569.v8;
create or replace view aggView8000266739541036430 as select v23, MIN(v35) as v35 from aggJoin7188679808528422131 group by v23;
create or replace view aggJoin1592144124036946171 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView8000266739541036430 where t.id=aggView8000266739541036430.v23 and production_year>2010;
create or replace view aggView5246646139039588412 as select v23, MIN(v36) as v36 from aggJoin7424453920291085915 group by v23;
create or replace view aggJoin372901998355945621 as select v24, v27, v35 as v35, v36 from aggJoin1592144124036946171 join aggView5246646139039588412 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin372901998355945621;
