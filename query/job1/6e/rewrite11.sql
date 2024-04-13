create or replace view aggView1763913284816666042 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin3065965674041451571 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView1763913284816666042 where ci.movie_id=aggView1763913284816666042.v23;
create or replace view aggView7404986548733991392 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4172186806444715477 as select v23, v37, v36 from aggJoin3065965674041451571 join aggView7404986548733991392 using(v14);
create or replace view aggView2272672900428647739 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin9051824044744106135 as select movie_id as v23, v35 from movie_keyword as mk, aggView2272672900428647739 where mk.keyword_id=aggView2272672900428647739.v8;
create or replace view aggView7548629563125475005 as select v23, MIN(v35) as v35 from aggJoin9051824044744106135 group by v23,v35;
create or replace view aggJoin6355740369138931452 as select v37 as v37, v36 as v36, v35 from aggJoin4172186806444715477 join aggView7548629563125475005 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6355740369138931452;
