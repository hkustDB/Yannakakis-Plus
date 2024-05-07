create or replace view aggView4324728520446237078 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8640604201655763171 as select movie_id as v23, v36 from cast_info as ci, aggView4324728520446237078 where ci.person_id=aggView4324728520446237078.v14;
create or replace view aggView5908955434674636190 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin770016891065022785 as select movie_id as v23, v35 from movie_keyword as mk, aggView5908955434674636190 where mk.keyword_id=aggView5908955434674636190.v8;
create or replace view aggView8975897355396502449 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin7769293053895266099 as select v23, v35, v37 from aggJoin770016891065022785 join aggView8975897355396502449 using(v23);
create or replace view aggView4114770423057387811 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin7769293053895266099 group by v23;
create or replace view aggJoin6666369457728540258 as select v36 as v36, v35, v37 from aggJoin8640604201655763171 join aggView4114770423057387811 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6666369457728540258;
