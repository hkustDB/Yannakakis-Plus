create or replace view aggView7526471179518311342 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin396207238372774992 as select movie_id as v23, v35 from movie_keyword as mk, aggView7526471179518311342 where mk.keyword_id=aggView7526471179518311342.v8;
create or replace view aggView3193564351040661105 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin4421256751013326907 as select v23, v35, v37 from aggJoin396207238372774992 join aggView3193564351040661105 using(v23);
create or replace view aggView5374255737948959446 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin4421256751013326907 group by v23,v35,v37;
create or replace view aggJoin7687105084107136488 as select person_id as v14, v35, v37 from cast_info as ci, aggView5374255737948959446 where ci.movie_id=aggView5374255737948959446.v23;
create or replace view aggView1444338495594122883 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4443511610477155513 as select v35, v37, v36 from aggJoin7687105084107136488 join aggView1444338495594122883 using(v14);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4443511610477155513;
