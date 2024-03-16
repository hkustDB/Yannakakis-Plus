create or replace view aggView7747135918631205937 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin89051915770074538 as select movie_id as v23, v36 from cast_info as ci, aggView7747135918631205937 where ci.person_id=aggView7747135918631205937.v14;
create or replace view aggView5852561253102685410 as select v23, MIN(v36) as v36 from aggJoin89051915770074538 group by v23;
create or replace view aggJoin1025446892210516694 as select id as v23, title as v24, v36 from title as t, aggView5852561253102685410 where t.id=aggView5852561253102685410.v23 and production_year>2014;
create or replace view aggView8447982188839049188 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin1025446892210516694 group by v23;
create or replace view aggJoin5335350907990271995 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView8447982188839049188 where mk.movie_id=aggView8447982188839049188.v23;
create or replace view aggView7368599465463064565 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin5335350907990271995 group by v8;
create or replace view aggJoin1292449313815074323 as select keyword as v9, v36, v37 from keyword as k, aggView7368599465463064565 where k.id=aggView7368599465463064565.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1292449313815074323;
