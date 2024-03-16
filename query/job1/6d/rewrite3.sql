create or replace view aggView3777783090038472188 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin8642840230780603919 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView3777783090038472188 where mk.movie_id=aggView3777783090038472188.v23;
create or replace view aggView1950385009829477439 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin4685115629523464716 as select v23, v37 from aggJoin8642840230780603919 join aggView1950385009829477439 using(v8);
create or replace view aggView5307806266172076057 as select v23, MIN(v37) as v37 from aggJoin4685115629523464716 group by v23;
create or replace view aggJoin8832371752049912863 as select person_id as v14, v37 from cast_info as ci, aggView5307806266172076057 where ci.movie_id=aggView5307806266172076057.v23;
create or replace view aggView8032528420404580730 as select v14, MIN(v37) as v37 from aggJoin8832371752049912863 group by v14;
create or replace view aggJoin8054390791371729075 as select name as v15, v37 from name as n, aggView8032528420404580730 where n.id=aggView8032528420404580730.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin8054390791371729075;
