create or replace view aggView1513191354684206494 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6131472315083917166 as select movie_id as v23, v35 from movie_keyword as mk, aggView1513191354684206494 where mk.keyword_id=aggView1513191354684206494.v8;
create or replace view aggView7950261655928219775 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin7830667408647095121 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView7950261655928219775 where ci.movie_id=aggView7950261655928219775.v23;
create or replace view aggView455582070970027665 as select v23, MIN(v35) as v35 from aggJoin6131472315083917166 group by v23;
create or replace view aggJoin8046316325864675059 as select v14, v37 as v37, v35 from aggJoin7830667408647095121 join aggView455582070970027665 using(v23);
create or replace view aggView4468066186060459587 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin8046316325864675059 group by v14;
create or replace view aggJoin3421059828337207200 as select name as v15, v37, v35 from name as n, aggView4468066186060459587 where n.id=aggView4468066186060459587.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin3421059828337207200;
