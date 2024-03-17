create or replace view aggView8958229748179139738 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin6587284784807478538 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView8958229748179139738 where mk.movie_id=aggView8958229748179139738.v23;
create or replace view aggView1158489841364050148 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5752503163250104380 as select v23, v37, v35 from aggJoin6587284784807478538 join aggView1158489841364050148 using(v8);
create or replace view aggView7895148970484773156 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2695034763425223786 as select movie_id as v23, v36 from cast_info as ci, aggView7895148970484773156 where ci.person_id=aggView7895148970484773156.v14;
create or replace view aggView6796624460272264439 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin5752503163250104380 group by v23;
create or replace view aggJoin4798426148012030673 as select v36 as v36, v37, v35 from aggJoin2695034763425223786 join aggView6796624460272264439 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4798426148012030673;
