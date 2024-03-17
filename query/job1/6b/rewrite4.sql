create or replace view aggView891041914477784448 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6472991578088905924 as select movie_id as v23, v35 from movie_keyword as mk, aggView891041914477784448 where mk.keyword_id=aggView891041914477784448.v8;
create or replace view aggView4233709275310295820 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2872027667894753016 as select movie_id as v23, v36 from cast_info as ci, aggView4233709275310295820 where ci.person_id=aggView4233709275310295820.v14;
create or replace view aggView9221529198431526728 as select v23, MIN(v35) as v35 from aggJoin6472991578088905924 group by v23;
create or replace view aggJoin9216478914730175254 as select v23, v36 as v36, v35 from aggJoin2872027667894753016 join aggView9221529198431526728 using(v23);
create or replace view aggView474189619849629952 as select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin9216478914730175254 group by v23;
create or replace view aggJoin7222612745137013895 as select title as v24, v36, v35 from title as t, aggView474189619849629952 where t.id=aggView474189619849629952.v23 and production_year>2014;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin7222612745137013895;
