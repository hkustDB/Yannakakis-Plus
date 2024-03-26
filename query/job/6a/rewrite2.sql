create or replace view aggView3205842900492758508 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1733543452449015020 as select movie_id as v23, v35 from movie_keyword as mk, aggView3205842900492758508 where mk.keyword_id=aggView3205842900492758508.v8;
create or replace view aggView93215842688554965 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin7471075768791948435 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView93215842688554965 where ci.movie_id=aggView93215842688554965.v23;
create or replace view aggView2516318775731370341 as select v23, MIN(v35) as v35 from aggJoin1733543452449015020 group by v23;
create or replace view aggJoin6520009182697771974 as select v14, v37 as v37, v35 from aggJoin7471075768791948435 join aggView2516318775731370341 using(v23);
create or replace view aggView7006891723267121987 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin6520009182697771974 group by v14;
create or replace view aggJoin1886413119132731940 as select name as v15, v37, v35 from name as n, aggView7006891723267121987 where n.id=aggView7006891723267121987.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin1886413119132731940;
