create or replace view aggView8923599386721542735 as select id as v14, name as v36 from name as n;
create or replace view aggJoin1040185690072937221 as select movie_id as v23, v36 from cast_info as ci, aggView8923599386721542735 where ci.person_id=aggView8923599386721542735.v14;
create or replace view aggView4383923431388212330 as select v23, MIN(v36) as v36 from aggJoin1040185690072937221 group by v23;
create or replace view aggJoin4797377489296432298 as select id as v23, title as v24, v36 from title as t, aggView4383923431388212330 where t.id=aggView4383923431388212330.v23 and production_year>2000;
create or replace view aggView181186375599746461 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin4797377489296432298 group by v23;
create or replace view aggJoin5353315403627110575 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView181186375599746461 where mk.movie_id=aggView181186375599746461.v23;
create or replace view aggView1464917648358685110 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin5353315403627110575 group by v8;
create or replace view aggJoin898721973306598457 as select keyword as v9, v36, v37 from keyword as k, aggView1464917648358685110 where k.id=aggView1464917648358685110.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin898721973306598457;
