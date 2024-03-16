create or replace view aggView4188415594185880435 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3843963531115080399 as select movie_id as v23, v36 from cast_info as ci, aggView4188415594185880435 where ci.person_id=aggView4188415594185880435.v14;
create or replace view aggView8108835798951924208 as select v23, MIN(v36) as v36 from aggJoin3843963531115080399 group by v23;
create or replace view aggJoin6016497667777024228 as select id as v23, title as v24, v36 from title as t, aggView8108835798951924208 where t.id=aggView8108835798951924208.v23 and production_year>2014;
create or replace view aggView3695456571842450155 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin6016497667777024228 group by v23;
create or replace view aggJoin2720107512382750503 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView3695456571842450155 where mk.movie_id=aggView3695456571842450155.v23;
create or replace view aggView3934011359841589819 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin2720107512382750503 group by v8;
create or replace view aggJoin1019256876210369200 as select keyword as v9, v36, v37 from keyword as k, aggView3934011359841589819 where k.id=aggView3934011359841589819.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1019256876210369200;
