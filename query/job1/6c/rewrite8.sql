create or replace view aggView1337912523752467631 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7674706304706809608 as select movie_id as v23, v35 from movie_keyword as mk, aggView1337912523752467631 where mk.keyword_id=aggView1337912523752467631.v8;
create or replace view aggView4395282366899656600 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5453678344326939454 as select movie_id as v23, v36 from cast_info as ci, aggView4395282366899656600 where ci.person_id=aggView4395282366899656600.v14;
create or replace view aggView6454539957095007571 as select v23, MIN(v35) as v35 from aggJoin7674706304706809608 group by v23,v35;
create or replace view aggJoin67139310508114615 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView6454539957095007571 where t.id=aggView6454539957095007571.v23 and production_year>2014;
create or replace view aggView9183577011204448759 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin67139310508114615 group by v23,v35;
create or replace view aggJoin2572713097730436567 as select v36 as v36, v35, v37 from aggJoin5453678344326939454 join aggView9183577011204448759 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2572713097730436567;
