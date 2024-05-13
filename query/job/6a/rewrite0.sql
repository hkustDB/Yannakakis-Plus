create or replace view aggView3405332540694494131 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3626544060371228991 as select movie_id as v23, v35 from movie_keyword as mk, aggView3405332540694494131 where mk.keyword_id=aggView3405332540694494131.v8;
create or replace view aggView2903846279410978746 as select v23, MIN(v35) as v35 from aggJoin3626544060371228991 group by v23;
create or replace view aggJoin546706205935579064 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView2903846279410978746 where t.id=aggView2903846279410978746.v23 and production_year>2010;
create or replace view aggView4605602433417496988 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin546706205935579064 group by v23;
create or replace view aggJoin4196092661870521409 as select person_id as v14, v35, v37 from cast_info as ci, aggView4605602433417496988 where ci.movie_id=aggView4605602433417496988.v23;
create or replace view aggView8448555224010486817 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin4196092661870521409 group by v14;
create or replace view aggJoin5262148043416720451 as select name as v15, v35, v37 from name as n, aggView8448555224010486817 where n.id=aggView8448555224010486817.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin5262148043416720451;
