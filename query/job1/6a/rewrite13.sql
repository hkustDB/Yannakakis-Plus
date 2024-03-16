create or replace view aggView1217841838658557578 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin4137502458227024431 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView1217841838658557578 where ci.movie_id=aggView1217841838658557578.v23;
create or replace view aggView9216683339244819011 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5185882600207322351 as select movie_id as v23, v35 from movie_keyword as mk, aggView9216683339244819011 where mk.keyword_id=aggView9216683339244819011.v8;
create or replace view aggView6518329679745860216 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6098019426629018436 as select v23, v37 from aggJoin4137502458227024431 join aggView6518329679745860216 using(v14);
create or replace view aggView1005464581371470418 as select v23, MIN(v35) as v35 from aggJoin5185882600207322351 group by v23;
create or replace view aggJoin2936737069486400150 as select v37 as v37, v35 from aggJoin6098019426629018436 join aggView1005464581371470418 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2936737069486400150;
