create or replace view aggView422689007576239642 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin4110329201669684654 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView422689007576239642 where mk.movie_id=aggView422689007576239642.v23;
create or replace view aggView7403304952318093048 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4167495565997974506 as select movie_id as v23, v36 from cast_info as ci, aggView7403304952318093048 where ci.person_id=aggView7403304952318093048.v14;
create or replace view aggView6359802269601102661 as select v23, MIN(v36) as v36 from aggJoin4167495565997974506 group by v23;
create or replace view aggJoin8497551922745068297 as select v8, v37 as v37, v36 from aggJoin4110329201669684654 join aggView6359802269601102661 using(v23);
create or replace view aggView3744600093712148017 as select v8, MIN(v37) as v37, MIN(v36) as v36 from aggJoin8497551922745068297 group by v8;
create or replace view aggJoin6881700480452195718 as select keyword as v9, v37, v36 from keyword as k, aggView3744600093712148017 where k.id=aggView3744600093712148017.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6881700480452195718;
