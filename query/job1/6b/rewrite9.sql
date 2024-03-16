create or replace view aggView7972626017340983171 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin7678840398902457866 as select movie_id as v23, v35 from movie_keyword as mk, aggView7972626017340983171 where mk.keyword_id=aggView7972626017340983171.v8;
create or replace view aggView4247384395318943725 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7841189940968037982 as select movie_id as v23, v36 from cast_info as ci, aggView4247384395318943725 where ci.person_id=aggView4247384395318943725.v14;
create or replace view aggView58799917178194445 as select v23, MIN(v35) as v35 from aggJoin7678840398902457866 group by v23;
create or replace view aggJoin4467206281752179744 as select id as v23, title as v24, v35 from title as t, aggView58799917178194445 where t.id=aggView58799917178194445.v23 and production_year>2014;
create or replace view aggView965043134283844563 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin4467206281752179744 group by v23;
create or replace view aggJoin6613415221834314701 as select v36 as v36, v35, v37 from aggJoin7841189940968037982 join aggView965043134283844563 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6613415221834314701;
