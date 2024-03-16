create or replace view aggView2779955728156834081 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1324966581338131399 as select movie_id as v23, v35 from movie_keyword as mk, aggView2779955728156834081 where mk.keyword_id=aggView2779955728156834081.v8;
create or replace view aggView4369784113403111106 as select v23, MIN(v35) as v35 from aggJoin1324966581338131399 group by v23;
create or replace view aggJoin6902930488928014548 as select id as v23, title as v24, v35 from title as t, aggView4369784113403111106 where t.id=aggView4369784113403111106.v23 and production_year>2000;
create or replace view aggView3976352626120036564 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin6902930488928014548 group by v23;
create or replace view aggJoin1057423673543148024 as select person_id as v14, v35, v37 from cast_info as ci, aggView3976352626120036564 where ci.movie_id=aggView3976352626120036564.v23;
create or replace view aggView8825233395502736741 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin1057423673543148024 group by v14;
create or replace view aggJoin6579274019999509603 as select name as v15, v35, v37 from name as n, aggView8825233395502736741 where n.id=aggView8825233395502736741.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin6579274019999509603;
