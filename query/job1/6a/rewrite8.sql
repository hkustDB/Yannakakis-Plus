create or replace view aggView5492320468727332130 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin8726668311696970679 as select movie_id as v23, v35 from movie_keyword as mk, aggView5492320468727332130 where mk.keyword_id=aggView5492320468727332130.v8;
create or replace view aggView4905254492945709185 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3667962632901637491 as select movie_id as v23, v36 from cast_info as ci, aggView4905254492945709185 where ci.person_id=aggView4905254492945709185.v14;
create or replace view aggView2898305403173661249 as select v23, MIN(v35) as v35 from aggJoin8726668311696970679 group by v23;
create or replace view aggJoin7970419117905248541 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView2898305403173661249 where t.id=aggView2898305403173661249.v23 and production_year>2010;
create or replace view aggView7638792804692473912 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin7970419117905248541 group by v23;
create or replace view aggJoin8837221353131558478 as select v36 as v36, v35, v37 from aggJoin3667962632901637491 join aggView7638792804692473912 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8837221353131558478;
