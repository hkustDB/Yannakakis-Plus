create or replace view aggView1282980826342231715 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5723180572039323876 as select movie_id as v23, v35 from movie_keyword as mk, aggView1282980826342231715 where mk.keyword_id=aggView1282980826342231715.v8;
create or replace view aggView8656272635821841149 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin8674864625955242527 as select v23, v35, v37 from aggJoin5723180572039323876 join aggView8656272635821841149 using(v23);
create or replace view aggView4901840298335495656 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin8674864625955242527 group by v23;
create or replace view aggJoin5642595078015720255 as select person_id as v14, v35, v37 from cast_info as ci, aggView4901840298335495656 where ci.movie_id=aggView4901840298335495656.v23;
create or replace view aggView1779488617819974699 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin5642595078015720255 group by v14;
create or replace view aggJoin2576578549299798138 as select name as v15, v35, v37 from name as n, aggView1779488617819974699 where n.id=aggView1779488617819974699.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin2576578549299798138;
