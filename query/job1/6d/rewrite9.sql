create or replace view aggView4102654017839605484 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3568475677300732181 as select movie_id as v23, v36 from cast_info as ci, aggView4102654017839605484 where ci.person_id=aggView4102654017839605484.v14;
create or replace view aggView6303771725232908211 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin7524926719155039073 as select v23, v36, v37 from aggJoin3568475677300732181 join aggView6303771725232908211 using(v23);
create or replace view aggView602497910409741210 as select v23, MIN(v36) as v36, MIN(v37) as v37 from aggJoin7524926719155039073 group by v23;
create or replace view aggJoin1540420349427601290 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView602497910409741210 where mk.movie_id=aggView602497910409741210.v23;
create or replace view aggView1375245593046522429 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin1540420349427601290 group by v8;
create or replace view aggJoin6897973118237155063 as select keyword as v9, v36, v37 from keyword as k, aggView1375245593046522429 where k.id=aggView1375245593046522429.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6897973118237155063;
