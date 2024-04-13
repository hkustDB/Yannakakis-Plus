create or replace view aggView4693496407327349846 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin5903178582988578760 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView4693496407327349846 where mk.movie_id=aggView4693496407327349846.v23;
create or replace view aggView7817284751821522337 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin4824831317444303264 as select v23, v37, v35 from aggJoin5903178582988578760 join aggView7817284751821522337 using(v8);
create or replace view aggView2222237416704146411 as select id as v14, name as v36 from name as n;
create or replace view aggJoin1688681190573620869 as select movie_id as v23, v36 from cast_info as ci, aggView2222237416704146411 where ci.person_id=aggView2222237416704146411.v14;
create or replace view aggView2551951751270020206 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin4824831317444303264 group by v23,v35,v37;
create or replace view aggJoin7789411886227037182 as select v36 as v36, v37, v35 from aggJoin1688681190573620869 join aggView2551951751270020206 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7789411886227037182;
