create or replace view aggView7600109600966022 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7677444200770029519 as select movie_id as v23, v35 from movie_keyword as mk, aggView7600109600966022 where mk.keyword_id=aggView7600109600966022.v8;
create or replace view aggView254778530173822452 as select v23, MIN(v35) as v35 from aggJoin7677444200770029519 group by v23;
create or replace view aggJoin1303594031080327160 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView254778530173822452 where t.id=aggView254778530173822452.v23 and production_year>2000;
create or replace view aggView3176713559036681712 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3974195468699237935 as select movie_id as v23, v36 from cast_info as ci, aggView3176713559036681712 where ci.person_id=aggView3176713559036681712.v14;
create or replace view aggView5012482760003373953 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin1303594031080327160 group by v23;
create or replace view aggJoin7545980482818355974 as select v36 as v36, v35, v37 from aggJoin3974195468699237935 join aggView5012482760003373953 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7545980482818355974;
