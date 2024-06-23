create or replace view aggView796788779525002077 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3887081408558466765 as select movie_id as v23, v35 from movie_keyword as mk, aggView796788779525002077 where mk.keyword_id=aggView796788779525002077.v8;
create or replace view aggView196616832637030209 as select v23, MIN(v35) as v35 from aggJoin3887081408558466765 group by v23;
create or replace view aggJoin5600507809509583 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView196616832637030209 where t.id=aggView196616832637030209.v23 and production_year>2000;
create or replace view aggView1281525747448120980 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin5600507809509583 group by v23;
create or replace view aggJoin13288893382475337 as select person_id as v14, v35, v37 from cast_info as ci, aggView1281525747448120980 where ci.movie_id=aggView1281525747448120980.v23;
create or replace view aggView6896888359885436604 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin13288893382475337 group by v14;
create or replace view aggJoin2032736680243386956 as select name as v15, v35, v37 from name as n, aggView6896888359885436604 where n.id=aggView6896888359885436604.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin2032736680243386956;
