create or replace view aggView4414220171714784450 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6565626657061421520 as select movie_id as v23, v35 from movie_keyword as mk, aggView4414220171714784450 where mk.keyword_id=aggView4414220171714784450.v8;
create or replace view aggView5764673622696423891 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4496817608554266 as select movie_id as v23, v36 from cast_info as ci, aggView5764673622696423891 where ci.person_id=aggView5764673622696423891.v14;
create or replace view aggView4967399190794060747 as select v23, MIN(v35) as v35 from aggJoin6565626657061421520 group by v23;
create or replace view aggJoin3926054839021895059 as select v23, v36 as v36, v35 from aggJoin4496817608554266 join aggView4967399190794060747 using(v23);
create or replace view aggView7676923872428293943 as select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin3926054839021895059 group by v23;
create or replace view aggJoin3275043490958129222 as select title as v24, v36, v35 from title as t, aggView7676923872428293943 where t.id=aggView7676923872428293943.v23 and production_year>2000;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin3275043490958129222;
