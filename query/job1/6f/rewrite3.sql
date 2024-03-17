create or replace view aggView7455964589272705127 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6596993823562736373 as select movie_id as v23, v35 from movie_keyword as mk, aggView7455964589272705127 where mk.keyword_id=aggView7455964589272705127.v8;
create or replace view aggView503557603194618276 as select id as v14, name as v36 from name as n;
create or replace view aggJoin7038876397269836602 as select movie_id as v23, v36 from cast_info as ci, aggView503557603194618276 where ci.person_id=aggView503557603194618276.v14;
create or replace view aggView4548510089197022848 as select v23, MIN(v35) as v35 from aggJoin6596993823562736373 group by v23;
create or replace view aggJoin7818288635938195752 as select v23, v36 as v36, v35 from aggJoin7038876397269836602 join aggView4548510089197022848 using(v23);
create or replace view aggView5872565307585089739 as select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin7818288635938195752 group by v23;
create or replace view aggJoin5100272767927354360 as select title as v24, v36, v35 from title as t, aggView5872565307585089739 where t.id=aggView5872565307585089739.v23 and production_year>2000;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin5100272767927354360;
