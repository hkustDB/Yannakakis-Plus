create or replace view aggView4963471362474514472 as select id as v14, name as v36 from name as n;
create or replace view aggJoin8948665680207087244 as select movie_id as v23, v36 from cast_info as ci, aggView4963471362474514472 where ci.person_id=aggView4963471362474514472.v14;
create or replace view aggView2123963741565619331 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1632552044780152092 as select movie_id as v23, v35 from movie_keyword as mk, aggView2123963741565619331 where mk.keyword_id=aggView2123963741565619331.v8;
create or replace view aggView1800303948477219939 as select v23, MIN(v35) as v35 from aggJoin1632552044780152092 group by v23;
create or replace view aggJoin857677114257338121 as select id as v23, title as v24, v35 from title as t, aggView1800303948477219939 where t.id=aggView1800303948477219939.v23 and production_year>2000;
create or replace view aggView8699531794007700241 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin857677114257338121 group by v23;
create or replace view aggJoin6126401001162662329 as select v36 as v36, v35, v37 from aggJoin8948665680207087244 join aggView8699531794007700241 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6126401001162662329;
