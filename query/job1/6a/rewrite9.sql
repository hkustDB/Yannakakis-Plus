create or replace view aggView7404128005022101293 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2438346328695869938 as select movie_id as v23, v36 from cast_info as ci, aggView7404128005022101293 where ci.person_id=aggView7404128005022101293.v14;
create or replace view aggView4307120133483705828 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin162088050629827522 as select movie_id as v23, v35 from movie_keyword as mk, aggView4307120133483705828 where mk.keyword_id=aggView4307120133483705828.v8;
create or replace view aggView6266762166279885233 as select v23, MIN(v35) as v35 from aggJoin162088050629827522 group by v23,v35;
create or replace view aggJoin7428595095793062065 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView6266762166279885233 where t.id=aggView6266762166279885233.v23 and production_year>2010;
create or replace view aggView4464516393893958029 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin7428595095793062065 group by v23,v35;
create or replace view aggJoin3229810352955213412 as select v36 as v36, v35, v37 from aggJoin2438346328695869938 join aggView4464516393893958029 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3229810352955213412;
