create or replace view aggView4543340094288741802 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5922466197512268577 as select movie_id as v23, v35 from movie_keyword as mk, aggView4543340094288741802 where mk.keyword_id=aggView4543340094288741802.v8;
create or replace view aggView7050741435946203907 as select id as v14, name as v36 from name as n;
create or replace view aggJoin1003187817096661456 as select movie_id as v23, v36 from cast_info as ci, aggView7050741435946203907 where ci.person_id=aggView7050741435946203907.v14;
create or replace view aggView7745538156075040578 as select v23, MIN(v36) as v36 from aggJoin1003187817096661456 group by v23;
create or replace view aggJoin2965065715454870248 as select v23, v35 as v35, v36 from aggJoin5922466197512268577 join aggView7745538156075040578 using(v23);
create or replace view aggView446946599601595452 as select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin2965065715454870248 group by v23;
create or replace view aggJoin7292794620844895294 as select title as v24, v35, v36 from title as t, aggView446946599601595452 where t.id=aggView446946599601595452.v23 and production_year>2000;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin7292794620844895294;
