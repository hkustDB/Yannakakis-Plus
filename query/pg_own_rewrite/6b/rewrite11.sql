create or replace view aggView7053596538663956048 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin2674934184160680732 as select movie_id as v23, v35 from movie_keyword as mk, aggView7053596538663956048 where mk.keyword_id=aggView7053596538663956048.v8;
create or replace view aggView3984762891066240829 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8584813126491519076 as select movie_id as v23, v36 from cast_info as ci, aggView3984762891066240829 where ci.person_id=aggView3984762891066240829.v14;
create or replace view aggView6501649458208188206 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin2134297102501927682 as select v23, v36, v37 from aggJoin8584813126491519076 join aggView6501649458208188206 using(v23);
create or replace view aggView3690344768698274177 as select v23, MIN(v35) as v35 from aggJoin2674934184160680732 group by v23,v35;
create or replace view aggJoin8345651273494081835 as select v36 as v36, v37 as v37, v35 from aggJoin2134297102501927682 join aggView3690344768698274177 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8345651273494081835;
