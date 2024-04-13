create or replace view aggView5381534719925610821 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin1227847870995142549 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView5381534719925610821 where mk.movie_id=aggView5381534719925610821.v23;
create or replace view aggView9117142581876420041 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin6654651078713991949 as select v23, v37, v35 from aggJoin1227847870995142549 join aggView9117142581876420041 using(v8);
create or replace view aggView2971139658906755385 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1525295395037159118 as select movie_id as v23, v36 from cast_info as ci, aggView2971139658906755385 where ci.person_id=aggView2971139658906755385.v14;
create or replace view aggView4710728611591728665 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin6654651078713991949 group by v23,v37,v35;
create or replace view aggJoin7672652646606424695 as select v36 as v36, v37, v35 from aggJoin1525295395037159118 join aggView4710728611591728665 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7672652646606424695;
