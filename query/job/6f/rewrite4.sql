create or replace view aggView8884674214243050713 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5383251602061133759 as select movie_id as v23, v35 from movie_keyword as mk, aggView8884674214243050713 where mk.keyword_id=aggView8884674214243050713.v8;
create or replace view aggView2054359148050556395 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin7008657184232036417 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView2054359148050556395 where ci.movie_id=aggView2054359148050556395.v23;
create or replace view aggView7766297169138939189 as select v23, MIN(v35) as v35 from aggJoin5383251602061133759 group by v23;
create or replace view aggJoin1029505729606112304 as select v14, v37 as v37, v35 from aggJoin7008657184232036417 join aggView7766297169138939189 using(v23);
create or replace view aggView3287401939557328084 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin1029505729606112304 group by v14;
create or replace view aggJoin58729866883868527 as select name as v15, v37, v35 from name as n, aggView3287401939557328084 where n.id=aggView3287401939557328084.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin58729866883868527;
