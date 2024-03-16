create or replace view aggView6974419323516924900 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8188657714783713652 as select movie_id as v23, v36 from cast_info as ci, aggView6974419323516924900 where ci.person_id=aggView6974419323516924900.v14;
create or replace view aggView4873563677297754605 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin7793287198866106298 as select v23, v36 from aggJoin8188657714783713652 join aggView4873563677297754605 using(v23);
create or replace view aggView7523199910065933526 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4615339574140318458 as select movie_id as v23, v35 from movie_keyword as mk, aggView7523199910065933526 where mk.keyword_id=aggView7523199910065933526.v8;
create or replace view aggView2301388419944389971 as select v23, MIN(v36) as v36 from aggJoin7793287198866106298 group by v23;
create or replace view aggJoin8313377618004322146 as select v35 as v35, v36 from aggJoin4615339574140318458 join aggView2301388419944389971 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8313377618004322146;
