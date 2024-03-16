create or replace view aggView6960697889094649732 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin1136022280080571982 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView6960697889094649732 where ci.movie_id=aggView6960697889094649732.v23;
create or replace view aggView5762622697630931775 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3681886745281980663 as select v23, v37 from aggJoin1136022280080571982 join aggView5762622697630931775 using(v14);
create or replace view aggView7315141075999004690 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7089216788285435175 as select movie_id as v23, v35 from movie_keyword as mk, aggView7315141075999004690 where mk.keyword_id=aggView7315141075999004690.v8;
create or replace view aggView194351562468275777 as select v23, MIN(v37) as v37 from aggJoin3681886745281980663 group by v23;
create or replace view aggJoin6999117148913604520 as select v35 as v35, v37 from aggJoin7089216788285435175 join aggView194351562468275777 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6999117148913604520;
