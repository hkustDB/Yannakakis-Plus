create or replace view aggView6826681906539858054 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin9126154144406617339 as select movie_id as v23, v35 from movie_keyword as mk, aggView6826681906539858054 where mk.keyword_id=aggView6826681906539858054.v8;
create or replace view aggView5553682542697110456 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2553603291573785239 as select movie_id as v23, v36 from cast_info as ci, aggView5553682542697110456 where ci.person_id=aggView5553682542697110456.v14;
create or replace view aggView2510500331277779497 as select v23, MIN(v35) as v35 from aggJoin9126154144406617339 group by v23;
create or replace view aggJoin7772812547689796005 as select v23, v36 as v36, v35 from aggJoin2553603291573785239 join aggView2510500331277779497 using(v23);
create or replace view aggView2527089759180474646 as select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin7772812547689796005 group by v23;
create or replace view aggJoin8800308170727492829 as select title as v24, v36, v35 from title as t, aggView2527089759180474646 where t.id=aggView2527089759180474646.v23 and production_year>2014;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin8800308170727492829;
