create or replace view aggView4957117837897034999 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin748422451210717715 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView4957117837897034999 where ci.movie_id=aggView4957117837897034999.v23;
create or replace view aggView1948113072861088800 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin163401363464582222 as select v23, v37 from aggJoin748422451210717715 join aggView1948113072861088800 using(v14);
create or replace view aggView4904469288967228207 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7895515682311507559 as select movie_id as v23, v35 from movie_keyword as mk, aggView4904469288967228207 where mk.keyword_id=aggView4904469288967228207.v8;
create or replace view aggView396728199736418366 as select v23, MIN(v37) as v37 from aggJoin163401363464582222 group by v23;
create or replace view aggJoin2863466769073456406 as select v35 as v35, v37 from aggJoin7895515682311507559 join aggView396728199736418366 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2863466769073456406;
