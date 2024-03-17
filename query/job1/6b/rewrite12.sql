create or replace view aggView7954521141738263511 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8501842422175396957 as select movie_id as v23, v36 from cast_info as ci, aggView7954521141738263511 where ci.person_id=aggView7954521141738263511.v14;
create or replace view aggView4014799076466212866 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin7525574116501036571 as select v23, v36, v37 from aggJoin8501842422175396957 join aggView4014799076466212866 using(v23);
create or replace view aggView7088621302882870548 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1283793166505287001 as select movie_id as v23, v35 from movie_keyword as mk, aggView7088621302882870548 where mk.keyword_id=aggView7088621302882870548.v8;
create or replace view aggView2044767821339501878 as select v23, MIN(v36) as v36, MIN(v37) as v37 from aggJoin7525574116501036571 group by v23;
create or replace view aggJoin8002719001556406347 as select v35 as v35, v36, v37 from aggJoin1283793166505287001 join aggView2044767821339501878 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8002719001556406347;
