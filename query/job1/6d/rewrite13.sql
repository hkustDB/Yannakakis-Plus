create or replace view aggView7826969175286471395 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin7992590996798189640 as select movie_id as v23, v35 from movie_keyword as mk, aggView7826969175286471395 where mk.keyword_id=aggView7826969175286471395.v8;
create or replace view aggView181170209254724416 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6191963200691046015 as select movie_id as v23, v36 from cast_info as ci, aggView181170209254724416 where ci.person_id=aggView181170209254724416.v14;
create or replace view aggView6870358955285748199 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin571905539153263673 as select v23, v35, v37 from aggJoin7992590996798189640 join aggView6870358955285748199 using(v23);
create or replace view aggView5200576420601563016 as select v23, MIN(v36) as v36 from aggJoin6191963200691046015 group by v23;
create or replace view aggJoin3942013253219079462 as select v35 as v35, v37 as v37, v36 from aggJoin571905539153263673 join aggView5200576420601563016 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3942013253219079462;
