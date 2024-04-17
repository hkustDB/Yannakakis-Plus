create or replace view aggView53666338473011454 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin6899039068846932735 as select movie_id as v23, v35 from movie_keyword as mk, aggView53666338473011454 where mk.keyword_id=aggView53666338473011454.v8;
create or replace view aggView1205797022988679490 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin2134448355437200758 as select v23, v35, v37 from aggJoin6899039068846932735 join aggView1205797022988679490 using(v23);
create or replace view aggView1606275855275103165 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin532777216914326025 as select movie_id as v23, v36 from cast_info as ci, aggView1606275855275103165 where ci.person_id=aggView1606275855275103165.v14;
create or replace view aggView9043597132638869386 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin2134448355437200758 group by v23,v35,v37;
create or replace view aggJoin1584548419549987558 as select v36 as v36, v35, v37 from aggJoin532777216914326025 join aggView9043597132638869386 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1584548419549987558;
