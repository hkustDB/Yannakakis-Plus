create or replace view aggView7686916524942560010 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5507612552604108900 as select movie_id as v23, v35 from movie_keyword as mk, aggView7686916524942560010 where mk.keyword_id=aggView7686916524942560010.v8;
create or replace view aggView7732637058034369848 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8931781367099583495 as select movie_id as v23, v36 from cast_info as ci, aggView7732637058034369848 where ci.person_id=aggView7732637058034369848.v14;
create or replace view aggView1157533781569739315 as select v23, MIN(v35) as v35 from aggJoin5507612552604108900 group by v23;
create or replace view aggJoin6649831530573575674 as select v23, v36 as v36, v35 from aggJoin8931781367099583495 join aggView1157533781569739315 using(v23);
create or replace view aggView7209941419859454958 as select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin6649831530573575674 group by v23;
create or replace view aggJoin3970356430190354393 as select title as v24, v36, v35 from title as t, aggView7209941419859454958 where t.id=aggView7209941419859454958.v23 and production_year>2000;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin3970356430190354393;
