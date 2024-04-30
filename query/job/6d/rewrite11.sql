create or replace view aggView2637447794801448137 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2368489400493788972 as select movie_id as v23, v36 from cast_info as ci, aggView2637447794801448137 where ci.person_id=aggView2637447794801448137.v14;
create or replace view aggView8852085199621963458 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6380431900078395311 as select movie_id as v23, v35 from movie_keyword as mk, aggView8852085199621963458 where mk.keyword_id=aggView8852085199621963458.v8;
create or replace view aggView4790916070642107792 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin7542921254572839500 as select v23, v36, v37 from aggJoin2368489400493788972 join aggView4790916070642107792 using(v23);
create or replace view aggView9007754011511195394 as select v23, MIN(v35) as v35 from aggJoin6380431900078395311 group by v23;
create or replace view aggJoin7772702777361539436 as select v36 as v36, v37 as v37, v35 from aggJoin7542921254572839500 join aggView9007754011511195394 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7772702777361539436;
