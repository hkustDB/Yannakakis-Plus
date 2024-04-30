create or replace view aggView8878333437351494172 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3234731274916529623 as select movie_id as v23, v35 from movie_keyword as mk, aggView8878333437351494172 where mk.keyword_id=aggView8878333437351494172.v8;
create or replace view aggView2003706846988029045 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4687883806040699595 as select movie_id as v23, v36 from cast_info as ci, aggView2003706846988029045 where ci.person_id=aggView2003706846988029045.v14;
create or replace view aggView5898413754337133654 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin9161882231962056971 as select v23, v36, v37 from aggJoin4687883806040699595 join aggView5898413754337133654 using(v23);
create or replace view aggView7298023807802574344 as select v23, MIN(v35) as v35 from aggJoin3234731274916529623 group by v23;
create or replace view aggJoin3823440694811286361 as select v36 as v36, v37 as v37, v35 from aggJoin9161882231962056971 join aggView7298023807802574344 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3823440694811286361;
