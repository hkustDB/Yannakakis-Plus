create or replace view aggView8812718183117018354 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4715680797890525112 as select movie_id as v23, v36 from cast_info as ci, aggView8812718183117018354 where ci.person_id=aggView8812718183117018354.v14;
create or replace view aggView5871396848642040440 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin5858029757500245437 as select v23, v36, v37 from aggJoin4715680797890525112 join aggView5871396848642040440 using(v23);
create or replace view aggView5344831603871752475 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3919978924557308010 as select movie_id as v23, v35 from movie_keyword as mk, aggView5344831603871752475 where mk.keyword_id=aggView5344831603871752475.v8;
create or replace view aggView1401834823454184812 as select v23, MIN(v36) as v36, MIN(v37) as v37 from aggJoin5858029757500245437 group by v23;
create or replace view aggJoin2367957612375691039 as select v35 as v35, v36, v37 from aggJoin3919978924557308010 join aggView1401834823454184812 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2367957612375691039;
