create or replace view aggView6796736312720720945 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6014892399683555444 as select movie_id as v23, v36 from cast_info as ci, aggView6796736312720720945 where ci.person_id=aggView6796736312720720945.v14;
create or replace view aggView4606380071771830248 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin8330110810481533950 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView4606380071771830248 where mk.movie_id=aggView4606380071771830248.v23;
create or replace view aggView6769624106793745916 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin4433193987661537433 as select v23, v37, v35 from aggJoin8330110810481533950 join aggView6769624106793745916 using(v8);
create or replace view aggView6897025657758645660 as select v23, MIN(v36) as v36 from aggJoin6014892399683555444 group by v23;
create or replace view aggJoin3673499771206779687 as select v37 as v37, v35 as v35, v36 from aggJoin4433193987661537433 join aggView6897025657758645660 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3673499771206779687;
